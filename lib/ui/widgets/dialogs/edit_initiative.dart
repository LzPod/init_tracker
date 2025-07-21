import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/interface/initiative_entity.dart';

class EditInitiativeDialog extends StatefulWidget {
  const EditInitiativeDialog({
    super.key,
    required this.initiativeEntity,
    required this.onInitiativeUpdated,
  });

  final InitiativeEntity initiativeEntity;
  final void Function(int) onInitiativeUpdated;

  @override
  State<EditInitiativeDialog> createState() => _EditInitiativeDialogState();
}

class _EditInitiativeDialogState extends State<EditInitiativeDialog> {
  final TextEditingController newInitiative = TextEditingController();

  @override
  void dispose() {
    newInitiative.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Edit Initiative'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newInitiative,
              decoration: const InputDecoration(
                labelText: 'New Initiative',
                hintText: 'Enter new initiative value',
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
                    final int initiative =
                        int.tryParse(newInitiative.text.trim()) ?? 0;
                    if (initiative > 0) {
                      widget.onInitiativeUpdated(initiative);
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Initiative value cannot be empty.'),
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
