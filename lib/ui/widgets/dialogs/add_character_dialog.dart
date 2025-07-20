import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';

class AddCharacterDialog extends StatefulWidget {
  const AddCharacterDialog({super.key});

  @override
  State<AddCharacterDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddCharacterDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController initiativeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    initiativeController.dispose();
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
              controller: initiativeController,
              decoration: const InputDecoration(
                labelText: 'Initiative',
                hintText: 'Enter initiative value',
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
                    final String initiativeText =
                        initiativeController.text.trim();

                    if (name.isNotEmpty && initiativeText.isNotEmpty) {
                      final int? initiative = int.tryParse(initiativeText);
                      if (initiative != null) {
                        Navigator.of(context).pop(Character(
                          name: name,
                          initiative: initiative,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter a valid initiative number'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
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
