import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void removeParty(Party party) {
    state = state.where((p) => p != party).toList();
  }

  void clearParties() {
    state = [];
  }
}

final partiesProvider = StateNotifierProvider<PartyNotifier, List<Party>>(
  (ref) => PartyNotifier(),
);
