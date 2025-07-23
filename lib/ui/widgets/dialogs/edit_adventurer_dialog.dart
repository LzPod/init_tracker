import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/theme/colors.dart';

class EditAdventurerDialog extends StatefulWidget {
  const EditAdventurerDialog({
    super.key,
    required this.adventurer,
    required this.onAdventurerUpdated,
  });

  final Character adventurer;
  final void Function(Character) onAdventurerUpdated;

  @override
  State<EditAdventurerDialog> createState() => _EditAdventurerDialogState();
}

class _EditAdventurerDialogState extends State<EditAdventurerDialog> {
  final TextEditingController newAdventurerName = TextEditingController();
  final TextEditingController newHitPoints = TextEditingController();
  final TextEditingController newArmorClass = TextEditingController();

  @override
  void dispose() {
    newAdventurerName.dispose();
    newHitPoints.dispose();
    newArmorClass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Adventurer',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New name',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: newAdventurerName,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Enter new name',
                      hintStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white54,
                              ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // Hit points
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hit points',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: newHitPoints,
                          style: Theme.of(context).textTheme.bodyLarge,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Hit points',
                            hintStyle:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white54,
                                    ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Armor class
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Armor Class',
                          style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: newArmorClass,
                          style: Theme.of(context).textTheme.bodyLarge,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Armor class',
                            hintStyle:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white54,
                                    ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      // Muted red/burgundy color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (newAdventurerName.text.isNotEmpty) {
                          widget.onAdventurerUpdated(
                            Character(
                              id: widget.adventurer.id,
                              name: newAdventurerName.text.trim(),
                              hitPoints:
                                  int.tryParse(newHitPoints.text.trim()) ?? 0,
                              armorClass:
                                  int.tryParse(newArmorClass.text.trim()) ?? 10,
                            ),
                          );
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Adventurer name cannot be empty.'),
                            ),
                          );
                        }
                      },
                      child: Text('Confirm',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
