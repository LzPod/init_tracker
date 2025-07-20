import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_init_tracker/models/party.dart';

class PartyRepository {
  static const _boxName = 'partiesBox';
  static const _key = 'parties';

  Future<void> save(List<Party> parties) async {
    final box = Hive.box(_boxName);
    final serialized = parties.map((p) => p.toMap()).toList();
    await box.put(_key, serialized);
  }

  List<Party> load() {
    final box = Hive.box(_boxName);
    final data = box.get(_key, defaultValue: []);
    return (data as List)
        .map((e) => Party.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
