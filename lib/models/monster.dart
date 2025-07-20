import 'package:uuid/uuid.dart';

class Monster {
  final String id;
  final String name;
  final int initiative;
  final int? damageDealt;

  Monster({
    String? id,
    required this.name,
    required this.initiative,
    this.damageDealt,
  }) : id = id ?? const Uuid().v4();
}
