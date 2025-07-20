import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_init_tracker/models/party.dart';

Future<void> hiveSetup() async {
  await Hive.initFlutter();

  // Register adapters
  // Hive.registerAdapter(CharacterAdapter());
  // Hive.registerAdapter(PartyAdapter());

  // Open boxes
  await Hive.openBox<Party>('partiesBox');
}
