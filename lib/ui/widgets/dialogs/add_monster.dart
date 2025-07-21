import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/monster.dart';

class AddMonsterDialog extends StatefulWidget {
  const AddMonsterDialog({super.key});

  @override
  State<AddMonsterDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddMonsterDialog> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
                labelText: 'Monster Name',
                hintText: 'Enter monster name',
              ),
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
                    if (name.isNotEmpty) {
                      Navigator.of(context).pop(Monster(
                        name: name,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Monster name cannot be empty.'),
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
