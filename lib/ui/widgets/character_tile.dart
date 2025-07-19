import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';

class CharacterTile extends StatelessWidget {
  const CharacterTile(
      {super.key, required this.character, required this.onDismissed});

  final Character character;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('character_tile'),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        onDismissed();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${character.name} removed'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: ListTile(
        leading: Text(character.initiative.toString()),
        title: Text(character.name),
        subtitle: Text(
            '${character.armorClass != null ? 'AC: ${character.armorClass} • ' : ''}${character.hitPoints != null ? 'HP: ${character.hitPoints}' : ''}'),
      ),
    );
  }
}
