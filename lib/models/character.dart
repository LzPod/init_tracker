import 'package:simple_init_tracker/models/interface/initiative_entity.dart';
import 'package:uuid/uuid.dart';

class Character implements InitiativeEntity {
  final String id;
  final String name;
  final int? initiative;
  final int? armorClass;
  final int? hitPoints;

  Character({
    String? id,
    required this.name,
    this.initiative,
    this.armorClass,
    this.hitPoints,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'initiative': initiative,
        'armorClass': armorClass,
        'hitPoints': hitPoints,
      };

  factory Character.fromMap(Map<String, dynamic> map) => Character(
        id: map['id'],
        name: map['name'],
        initiative: map['initiative'],
        armorClass: map['armorClass'],
        hitPoints: map['hitPoints'],
      );
}
