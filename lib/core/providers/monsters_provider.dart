import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/repositories/monsters_repository.dart';
import 'package:simple_init_tracker/models/monster.dart';

class MonsterNotifier extends StateNotifier<List<Monster>> {
  MonsterNotifier() : super([]) {
    _load();
  }

  final MonstersRepository _repo = MonstersRepository();

  /// State: List of monsters in the application.
  /// This is a list of [Monster] objects that represent the monsters
  /// currently being tracked in the application.
  /// The list is sorted by initiative in descending order,
  /// and by name in case of ties.

  void _save() {
    _repo.save(state);
  }

  void _load() {
    state = _repo.load();
    _sortMonsters();
  }

  void addMonster(String name) {
    final monster = Monster(name: name);
    state = [...state, monster];
    _sortMonsters();
    _save();
  }

  void removeMonster(String id) {
    state = state.where((monster) => monster.id != id).toList();
    _sortMonsters();
    _save();
  }

  void clearMonsters() {
    state = [];
    _save();
  }

  void _sortMonsters() {
    state.sort((a, b) {
      final initiativeA = a.initiative ?? 0;
      final initiativeB = b.initiative ?? 0;

      if (initiativeA != initiativeB) {
        return initiativeB.compareTo(initiativeA);
      } else {
        return a.name.compareTo(b.name);
      }
    });
    _save();
  }

  // void editMonster(Monster oldMonster, Monster newMonster) {
  //   state = state.map((c) => c == oldMonster ? newMonster : c).toList();
  //   _sortMonsters();
  //   _save();
  // }

  void updateMonster(String id, String newName) {
    state = [
      for (final monster in state)
        if (monster.id == id) monster.copyWith(name: newName) else monster
    ];
    _sortMonsters();
    _save();
  }
}

final monstersProvider = StateNotifierProvider<MonsterNotifier, List<Monster>>(
  (ref) => MonsterNotifier(),
);
