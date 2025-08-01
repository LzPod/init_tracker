import 'package:flutter/material.dart';
import 'package:simple_init_tracker/l10n/gen_l10n/app_localizations.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/theme/colors.dart';

class AddAdventurerDialog extends StatefulWidget {
  const AddAdventurerDialog({super.key});

  @override
  State<AddAdventurerDialog> createState() => _AddCharacterDialogState();
}

class _AddCharacterDialogState extends State<AddAdventurerDialog> {
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
            // Title
            Text(AppLocalizations.of(context).addCharacterTitle,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),

            // Name field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).name,
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: nameController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).name,
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

            // Hit points and Armor class row
            Row(
              children: [
                // Hit points
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).hitPoints,
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
                          controller: hitPointsController,
                          style: Theme.of(context).textTheme.bodyLarge,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).hitPoints,
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
                      Text(AppLocalizations.of(context).armorClass,
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
                          controller: armorController,
                          style: Theme.of(context).textTheme.bodyLarge,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).armorClass,
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

            // Buttons
            Row(
              children: [
                // Cancel button
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

                // Confirm button
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      // Muted red/burgundy color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
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
                            SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .nameRequiredError),
                            ),
                          );
                        }
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
