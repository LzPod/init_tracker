import 'package:simple_init_tracker/models/character.dart';
import 'package:uuid/uuid.dart';

class Party {
  final String id;
  final String name;
  final List<Character> characters;

  Party({
    String? id,
    required this.name,
    required this.characters,
  }) : id = id ?? const Uuid().v4();
}
