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
            ? '${widget.monster.name} (x$quantity)'
            : widget.monster.name,
        initiative: widget.monster.initiative,
      );
      initiativeNotifier.addEntity(groupMonster);
    } else {
      for (int i = 1; i <= quantity; i++) {
        final individualMonster = Monster(
          name: quantity > 1
              ? '${widget.monster.name} ${i}'
              : widget.monster.name,
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
    return SimpleDialog(
      title: Text('Add ${widget.monster.name} to initiative'),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                hintText: 'Enter the number of monsters',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Initiative Type:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            SegmentedButton<InitiativeType>(
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
              selected: {selectedType},
              onSelectionChanged: (Set<InitiativeType> selection) {
                setState(() {
                  selectedType = selection.first;
                });
              },
              showSelectedIcon: false,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedType == InitiativeType.individual
                    ? 'Creates separate entries for each monster'
                    : 'Creates one entry for all monsters',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,
              ),
            ),
            const SizedBox(height: 24),
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
                FilledButton(
                  onPressed: _addToInitiative,
                  child: const Text('Add to Initiative'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
