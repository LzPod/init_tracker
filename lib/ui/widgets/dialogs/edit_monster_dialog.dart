import 'package:flutter/material.dart';
import 'package:simple_init_tracker/l10n/gen_l10n/app_localizations.dart';
import 'package:simple_init_tracker/models/monster.dart';
import 'package:simple_init_tracker/theme/colors.dart';

class EditMonsterDialog extends StatefulWidget {
  const EditMonsterDialog({
    super.key,
    required this.monster,
    required this.onMonsterUpdated,
  });

  final Monster monster;
  final void Function(String) onMonsterUpdated;

  @override
  State<EditMonsterDialog> createState() => _EditMonsterDialogState();
}

class _EditMonsterDialogState extends State<EditMonsterDialog> {
  final TextEditingController newMonsterName = TextEditingController();

  @override
  void dispose() {
    newMonsterName.dispose();
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
            Text(AppLocalizations.of(context).editMonsterTitle,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).newName,
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: newMonsterName,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).newName,
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
                      AppLocalizations.of(context).cancel,
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
                        widget.onMonsterUpdated(
                          newMonsterName.text.trim() != ''
                              ? newMonsterName.text.trim()
                              : widget.monster.name,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context).confirm,
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
