import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_init_tracker/models/monster.dart';

class MonstersRepository {
  static const _boxName = 'monstersBox';
  static const _key = 'monsters';

  Future<void> save(List<Monster> monsters) async {
    final box = Hive.box(_boxName);
    final serialized = monsters.map((p) => p.toMap()).toList();
    await box.put(_key, serialized);
  }

  List<Monster> load() {
    final box = Hive.box(_boxName);
    final data = box.get(_key, defaultValue: []);
    return (data as List)
        .map((e) => Monster.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
