import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/models/interface/initiative_entity.dart';

class InitiativeNotifier extends StateNotifier<List<InitiativeEntity>> {
  InitiativeNotifier() : super([]);

  void addEntity(InitiativeEntity entity) {
    state = [...state, entity];
    _sort();
  }

  void removeEntity(InitiativeEntity entity) {
    state = state.where((e) => e.id != entity.id).toList();
  }

  void clear() {
    state = [];
  }

  void _sort() {
    state.sort((a, b) {
      final aInit = a.initiative ?? 0;
      final bInit = b.initiative ?? 0;

      if (aInit != bInit) {
        return bInit.compareTo(aInit);
      } else {
        return a.name.compareTo(b.name);
      }
    });
  }

  void updateInitiative(String id, int newInitiative) {
    state = [
      for (final entity in state)
        if (entity.id == id)
          entity.copyWith(initiative: newInitiative)
        else
          entity
    ];
    _sort();
  }
}

final initiativeProvider =
    StateNotifierProvider<InitiativeNotifier, List<InitiativeEntity>>(
  (ref) => InitiativeNotifier(),
);
