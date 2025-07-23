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

  void updateParty(Party party) {
    state = state.map((p) => p.id == party.id ? party : p).toList();
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

  void removeCharacterFromParty(String partyId, String characterId) {
    state = state.map((party) {
      if (party.id == partyId) {
        final updatedCharacters = party.characters
            .where((character) => character.id != characterId)
            .toList();
        return Party(
            id: party.id, name: party.name, characters: updatedCharacters);
      }
      return party;
    }).toList();
    _save();
  }

  void editCharacterInParty(
    String partyId,
    Character updatedCharacter,
  ) {
    state = state.map((party) {
      if (party.id == partyId) {
        final updatedCharacters = party.characters.map((character) {
          if (character.id == updatedCharacter.id) {
            return updatedCharacter;
          }
          return character;
        }).toList();
        return Party(
          id: party.id,
          name: party.name,
          characters: updatedCharacters,
        );
      }
      return party;
    }).toList();
    _save();
  }
}

final partyProvider = StateNotifierProvider<PartyNotifier, List<Party>>(
  (ref) => PartyNotifier(),
);
