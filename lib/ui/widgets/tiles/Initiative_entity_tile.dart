import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/models/interface/initiative_entity.dart';

class InitiativeEntityTile extends StatelessWidget {
  final InitiativeEntity initiativeEntity;
  final VoidCallback onDismissed;

  const InitiativeEntityTile({
    super.key,
    required this.initiativeEntity,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(initiativeEntity),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDismissed(),
      child: ListTile(
        leading: Text(
          initiativeEntity.initiative?.toString() ?? '-',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        title: Text(initiativeEntity.name),
        subtitle: Text(_buildStatsText(initiativeEntity)),
      ),
    );
  }

  String _buildStatsText(InitiativeEntity entity) {
    final stats = <String>[];

    if (entity is Character) {
      if (entity.armorClass != null) stats.add('AC: ${entity.armorClass}');
      if (entity.hitPoints != null) stats.add('HP: ${entity.hitPoints}');
    }

    return stats.join(' • ');
  }
}
