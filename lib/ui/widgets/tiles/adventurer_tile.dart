import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_init_tracker/models/character.dart';

//TODO: Use apptheme

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
    return GestureDetector(
      onTap: onTap ?? onEdit,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C3550),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (!isSelectable)
              SvgPicture.asset(
                'assets/icon/adventurer_icon.svg',
                height: 40,
                width: 40,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              )
            else
              Checkbox(
                value: isSelected,
                onChanged: (_) => onTap?.call(),
                activeColor: Colors.white,
                checkColor: const Color(0xFF2C3550),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'AC: ${character.armorClass} • HP: ${character.hitPoints}/${character.hitPoints}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (onDelete != null)
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.close,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20)),
          ],
        ),
      ),
    );
  }
}
