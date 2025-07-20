import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/models/character.dart';

class PartyMemberTile extends ConsumerWidget {
  const PartyMemberTile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        // TODO: Implement edit character functionality
      },
      title: Text(character.name),
      subtitle: Text(
          '${character.armorClass != null ? 'AC: ${character.armorClass} • ' : ''}${character.hitPoints != null ? 'HP: ${character.hitPoints}' : ''}'),
    );
  }
}
