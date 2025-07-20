import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/party.dart';

class AddPartyDialog extends StatefulWidget {
  const AddPartyDialog({super.key});

  @override
  State<AddPartyDialog> createState() => _AddPartyDialogState();
}

class _AddPartyDialogState extends State<AddPartyDialog> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Add New Party'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Party Name',
                hintText: 'Enter party name',
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
                      Navigator.of(context).pop(Party(
                        name: name,
                        characters: [],
                      ));
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
