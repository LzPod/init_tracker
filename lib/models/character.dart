import 'package:uuid/uuid.dart';

class Character {
  final String id;
  final String name;
  final int initiative;
  final int? armorClass;
  final int? hitPoints;
  final bool isMonster;

  Character({
    String? id,
    required this.name,
    required this.initiative,
    this.armorClass,
    this.hitPoints,
    required this.isMonster,
  }) : id = id ?? const Uuid().v4();
}
