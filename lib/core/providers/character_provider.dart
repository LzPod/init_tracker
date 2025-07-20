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
    _sortCharacters();
  }

  void clearCharacters() {
    state = [];
  }

  void _sortCharacters() {
    state.sort((a, b) {
      final initiativeA = a.initiative ?? 0;
      final initiativeB = b.initiative ?? 0;

      if (initiativeA != initiativeB) {
        return initiativeB.compareTo(initiativeA);
      } else {
        return a.name.compareTo(b.name);
      }
    });
  }

  void editCharacter(Character oldCharacter, Character newCharacter) {
    state = state.map((c) => c == oldCharacter ? newCharacter : c).toList();
    _sortCharacters();
  }
}

final characterProvider =
    StateNotifierProvider<CharacterNotifier, List<Character>>(
  (ref) => CharacterNotifier(),
);
