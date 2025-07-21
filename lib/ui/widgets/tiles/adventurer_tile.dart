import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';

class AdventurerTile extends StatelessWidget {
  const AdventurerTile({
    super.key,
    required this.character,
    this.isSelectable = false,
    this.isSelected = false,
    this.onTap,
  });

  final Character character;
  final bool isSelectable;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (isSelectable) {
      return ListTile(
        leading: Checkbox(
          value: isSelected,
          onChanged: (_) => onTap?.call(),
        ),
        title: Text(character.name),
        onTap: onTap,
      );
    }

    return ListTile(
      title: Text(character.name),
    );
  }
}
