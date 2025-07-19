import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/character_provider.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/ui/widgets/add_character_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/character_tile.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  void _showAddCharacterDialog(BuildContext context, WidgetRef ref) async {
    final Character? newCharacter = await showDialog<Character>(
      context: context,
      builder: (_) => const AddCharacterDialog(),
    );

    if (newCharacter != null) {
      ref.read(characterProvider.notifier).addCharacter(newCharacter);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(characterProvider);

    return Scaffold(
      body: characters.isEmpty
          ? Center(
              child: Text(
                'No characters added yet.\nTap the + button to add a character.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return CharacterTile(
                  character: characters[index],
                  onDismissed: () {
                    ref
                        .read(characterProvider.notifier)
                        .removeCharacter(characters[index]);
                  },
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCharacterDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
