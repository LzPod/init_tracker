import 'package:uuid/uuid.dart';

import 'interface/initiative_entity.dart';

class Monster implements InitiativeEntity {
  final String id;
  final String name;
  final int? initiative;
  final int? damageDealt;

  Monster({
    String? id,
    required this.name,
    this.initiative,
    this.damageDealt,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'initiative': initiative,
      'damageDealt': damageDealt,
    };
  }

  factory Monster.fromMap(Map<String, dynamic> map) {
    return Monster(
      id: map['id'],
      name: map['name'],
      initiative: map['initiative'],
      damageDealt: map['damageDealt'],
    );
  }
}
