import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/models/party.dart';

class PartyNotifier extends StateNotifier<List<Party>> {
  PartyNotifier() : super([]);

  /// State: List of parties in the application.
  /// This is a list of [Party] objects that represent the parties
  /// currently being tracked in the application.

  void addParty(String name) {
    final party = Party(name: name, characters: []);
    state = [...state, party];
  }

  void removeParty(String id) {
    state = state.where((party) => party.id != id).toList();
  }

  void clearParties() {
    state = [];
  }

  void addCharacterToParty(Party party, Character character) {
    final updatedParty = Party(
      id: party.id,
      name: party.name,
      characters: [...party.characters, character],
    );
    state = state.map((p) => p == party ? updatedParty : p).toList();
  }

  void removeCharacterFromParty(Party party, Character character) {
    final updatedParty = Party(
      id: party.id,
      name: party.name,
      characters: party.characters.where((c) => c != character).toList(),
    );
    state = state.map((p) => p == party ? updatedParty : p).toList();
  }
}

final partyProvider = StateNotifierProvider<PartyNotifier, List<Party>>(
  (ref) => PartyNotifier(),
);
