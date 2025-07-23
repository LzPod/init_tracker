import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/initiative_provider.dart';
import 'package:simple_init_tracker/models/monster.dart';
import 'package:simple_init_tracker/ui/pages/main_page.dart';

enum InitiativeType { individual, group }

class AddMonsterToInitiativeDialog extends ConsumerStatefulWidget {
  const AddMonsterToInitiativeDialog({
    super.key,
    required this.monster,
  });

  final Monster monster;

  @override
  ConsumerState<AddMonsterToInitiativeDialog> createState() =>
      _AddMonsterToInitiativeDialogState();
}

class _AddMonsterToInitiativeDialogState
    extends ConsumerState<AddMonsterToInitiativeDialog> {
  final TextEditingController quantityController =
      TextEditingController(text: '1');
  InitiativeType selectedType = InitiativeType.individual;

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  void _addToInitiative() {
    final int quantity = int.tryParse(quantityController.text.trim()) ?? 0;

    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid quantity.'),
        ),
      );
      return;
    }

    final initiativeNotifier = ref.read(initiativeProvider.notifier);

    if (selectedType == InitiativeType.group) {
      final groupMonster = Monster(
        name: quantity > 1
            ? '$quantity ${widget.monster.name}'
            : widget.monster.name,
        initiative: widget.monster.initiative,
      );
      initiativeNotifier.addEntity(groupMonster);
    } else {
      for (int i = 1; i <= quantity; i++) {
        final individualMonster = Monster(
          name:
              quantity > 1 ? '${widget.monster.name} $i' : widget.monster.name,
          initiative: widget.monster.initiative,
        );
        initiativeNotifier.addEntity(individualMonster);
      }
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
      (route) => false,
    );
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
            Text('Add ${widget.monster.name} to initiative',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: quantityController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Name',
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
            Text('Initiative Type:',
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 6),
            SegmentedButton<InitiativeType>(
              style: Theme.of(context).segmentedButtonTheme.style,
              segments: const [
                ButtonSegment<InitiativeType>(
                  value: InitiativeType.individual,
                  label: Text('Individual'),
                  icon: Icon(Icons.person),
                ),
                ButtonSegment<InitiativeType>(
                  value: InitiativeType.group,
                  label: Text('Group'),
                  icon: Icon(Icons.groups),
                ),
              ],
              showSelectedIcon: false,
              selected: {selectedType},
              onSelectionChanged: (Set<InitiativeType> selection) {
                setState(() {
                  selectedType = selection.first;
                });
              },
            ),
            const SizedBox(height: 6),
            Text(
              selectedType == InitiativeType.individual
                  ? 'Creates separate entries for each monster'
                  : 'Creates one entry for all monsters',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      // Muted red/burgundy color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: _addToInitiative,
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
