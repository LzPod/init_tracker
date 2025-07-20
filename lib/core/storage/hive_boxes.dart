import 'package:hive_flutter/adapters.dart';
import 'package:simple_init_tracker/models/party.dart';

class HiveBoxes {
  static Box<Party> get partiesBox => Hive.box<Party>('partiesBox');
}
