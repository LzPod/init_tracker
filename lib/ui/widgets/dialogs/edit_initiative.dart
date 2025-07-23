import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/interface/initiative_entity.dart';
import 'package:simple_init_tracker/theme/colors.dart';

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
            Text('Edit Initiative',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New initiative',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: newInitiative,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Enter new initiative',
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
                        final int initiative =
                            int.tryParse(newInitiative.text.trim()) ?? 0;
                        if (initiative > 0) {
                          widget.onInitiativeUpdated(initiative);
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Initiative value cannot be empty.'),
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
