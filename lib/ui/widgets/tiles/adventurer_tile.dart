import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_init_tracker/models/character.dart';

class AdventurerTile extends StatelessWidget {
  const AdventurerTile({
    super.key,
    required this.character,
    this.isSelectable = false,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Character character;
  final bool isSelectable;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap ?? onEdit,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (!isSelectable)
              SvgPicture.asset(
                'assets/icon/adventurer_icon.svg',
                height: 40,
                width: 40,
              )
            else
              Checkbox(
                value: isSelected,
                onChanged: (_) => onTap?.call(),
                side: BorderSide(
                  color: colorScheme.primary,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                activeColor: colorScheme.primary,
                checkColor: colorScheme.secondary,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      StatIconText(
                        value: character.hitPoints,
                        assetPath: 'assets/icon/hit_points.svg',
                      ),
                      if (character.hitPoints != null)
                        const SizedBox(width: 16),
                      StatIconText(
                        value: character.armorClass,
                        assetPath: 'assets/icon/armor_class.svg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.close,
                  color: colorScheme.secondary,
                  size: 20,
                ),
              ),
          ],
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
