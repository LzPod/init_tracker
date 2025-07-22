import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/repositories/party_repository.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/models/party.dart';

class PartyNotifier extends StateNotifier<List<Party>> {
  final PartyRepository _repo = PartyRepository();

  PartyNotifier() : super([]) {
    _loadParties();
  }

  void _loadParties() {
    state = _repo.load();
  }

  void _save() {
    _repo.save(state);
  }

  void addParty(String name) {
    final party = Party(name: name, characters: []);
    state = [...state, party];
    _save();
  }

  void removeParty(String id) {
    state = state.where((party) => party.id != id).toList();
    _save();
  }

  void clearParties() {
    state = [];
    _save();
  }

  void addCharacterToParty(Party party, Character character) {
    final updatedParty = Party(
      id: party.id,
      name: party.name,
      characters: [...party.characters, character],
    );
    state = state.map((p) => p.id == party.id ? updatedParty : p).toList();
    _save();
  }
}

final partyProvider = StateNotifierProvider<PartyNotifier, List<Party>>(
  (ref) => PartyNotifier(),
);
