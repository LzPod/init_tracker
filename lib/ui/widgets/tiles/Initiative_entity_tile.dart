import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/models/interface/initiative_entity.dart';

class InitiativeEntityTile extends StatelessWidget {
  final InitiativeEntity initiativeEntity;
  final VoidCallback onDismissed;
  final void Function(InitiativeEntity)? onTap;

  const InitiativeEntityTile({
    super.key,
    required this.initiativeEntity,
    required this.onDismissed,
    this.onTap,
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
      child: GestureDetector(
        onTap: onTap != null ? () => onTap!(initiativeEntity) : null,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2C3550),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              if (initiativeEntity is Character)
                SvgPicture.asset(
                  'assets/icon/adventurer_icon.svg',
                  width: 40,
                  height: 40,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )
              else
                SvgPicture.asset(
                  'assets/icon/monster_icon.svg',
                  width: 40,
                  height: 40,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              const SizedBox(width: 16),

              // Name and stats
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      initiativeEntity.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _buildStatsText(initiativeEntity),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icon/d20.svg',
                    width: 46,
                    height: 46,
                  ),
                  Text(
                    initiativeEntity.initiative?.toString() ?? '-',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
