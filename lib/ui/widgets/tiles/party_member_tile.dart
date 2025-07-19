import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';

class PartyMemberTile extends StatelessWidget {
  const PartyMemberTile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(character.initiative.toString()),
      title: Text(character.name),
      subtitle: Text(
          '${character.armorClass != null ? 'AC: ${character.armorClass} • ' : ''}${character.hitPoints != null ? 'HP: ${character.hitPoints}' : ''}'),
    );
  }
}
