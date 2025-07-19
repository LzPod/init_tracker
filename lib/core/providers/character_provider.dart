//TODO

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/models/character.dart';

class CharacterNotifier extends StateNotifier<List<Character>> {
  CharacterNotifier() : super([]);

  /// State: List of characters in the application.
  /// This is a list of [Character] objects that represent the characters
  /// currently being tracked in the application.
  /// The list is sorted by initiative in descending order,
  /// and by name in case of ties.

  void addCharacter(Character character) {
    state = [...state, character];
    _sortCharacters();
  }

  void removeCharacter(Character character) {
    state = state.where((c) => c != character).toList();
  }

  void clearCharacters() {
    state = [];
  }

  void _sortCharacters() {
    state.sort((a, b) {
      if (a.initiative != b.initiative) {
        return b.initiative.compareTo(a.initiative);
      } else {
        return a.name.compareTo(b.name);
      }
    });
  }
}

// This provider manages the list of characters in the application.
final characterProvider =
    StateNotifierProvider<CharacterNotifier, List<Character>>(
  (ref) => CharacterNotifier(),
);
