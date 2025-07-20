import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';

class AddCharacterDialog extends StatefulWidget {
  const AddCharacterDialog({super.key});

  @override
  State<AddCharacterDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddCharacterDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hitPointsController = TextEditingController();
  final TextEditingController armorController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    hitPointsController.dispose();
    armorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add New Character'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Character Name',
                hintText: 'Enter character name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: hitPointsController,
              decoration: const InputDecoration(
                labelText: 'Hit Points (optional)',
                hintText: 'Enter hit points',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: armorController,
              decoration: const InputDecoration(
                labelText: 'Armor Class (optional)',
                hintText: 'Enter armor class',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    final String name = nameController.text.trim();
                    final String hitPointsText =
                        hitPointsController.text.trim();
                    final String armorText = armorController.text.trim();

                    if (name.isNotEmpty) {
                      final int? hitPoints = int.tryParse(hitPointsText);
                      final int? armorClass = int.tryParse(armorText);
                      Navigator.of(context).pop(Character(
                          name: name,
                          hitPoints: hitPoints,
                          armorClass: armorClass));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Character name cannot be empty.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
