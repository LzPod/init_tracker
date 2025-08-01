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
    final isCharacter = initiativeEntity is Character;

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
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                isCharacter
                    ? 'assets/icon/adventurer_icon.svg'
                    : 'assets/icon/monster_icon.svg',
                width: 40,
                height: 40,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      initiativeEntity.name,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (isCharacter)
                      Row(
                        children: [
                          StatIconText(
                            value: (initiativeEntity as Character).hitPoints,
                            assetPath: 'assets/icon/hit_points.svg',
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          if ((initiativeEntity as Character).hitPoints != null)
                            const SizedBox(width: 12),
                          StatIconText(
                            value: (initiativeEntity as Character).armorClass,
                            assetPath: 'assets/icon/armor_class.svg',
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ],
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
                  Text(initiativeEntity.initiative?.toString() ?? '',
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatIconText extends StatelessWidget {
  final int? value;
  final String assetPath;
  final Color? color;

  const StatIconText({
    super.key,
    required this.value,
    required this.assetPath,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null) return const SizedBox.shrink();

    final resolvedColor = color ?? Theme.of(context).colorScheme.onSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: resolvedColor,
              ),
        ),
        const SizedBox(width: 6),
        SvgPicture.asset(
          assetPath,
          height: 14,
          colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
        ),
      ],
    );
  }
}
