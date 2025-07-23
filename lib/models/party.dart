import 'package:uuid/uuid.dart';

import 'character.dart';

class Party {
  final String id;
  final String name;
  final List<Character> characters;

  Party({
    String? id,
    required this.name,
    required this.characters,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'characters': characters.map((c) => c.toMap()).toList(),
      };

  factory Party.fromMap(Map<String, dynamic> map) => Party(
        id: map['id'],
        name: map['name'],
        characters: (map['characters'] as List)
            .map((c) => Character.fromMap(Map<String, dynamic>.from(c)))
            .toList(),
      );

  Party copyWith({
    String? name,
    List<Character>? characters,
  }) {
    return Party(
      id: id,
      name: name ?? this.name,
      characters: characters ?? this.characters,
    );
  }
}
