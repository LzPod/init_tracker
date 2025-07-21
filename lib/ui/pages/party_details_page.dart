import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/party_provider.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/models/party.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_adventurer_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/adventurer_tile.dart';

class PartyDetailsPage extends ConsumerWidget {
  const PartyDetailsPage(
      {super.key, required this.partyId, this.isSelectionMode = false});

  final String partyId;
  final bool isSelectionMode;

  void _showAddCharacterDialog(BuildContext context, WidgetRef ref) async {
    final Character? newCharacter = await showDialog<Character>(
      context: context,
      builder: (_) => const AddAdventurerDialog(),
    );

    if (newCharacter != null) {
      final party = ref.read(partyProvider);
      ref.read(partyProvider.notifier).addCharacterToParty(
            party.firstWhere((p) => p.id == partyId),
            newCharacter,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final party = ref.watch(partyProvider).firstWhere(
          (p) => p.id == partyId,
          orElse: () => Party(name: 'Unknown', characters: []),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(party.name),
      ),
      body: ListView.builder(
          itemCount: party.characters.length,
          itemBuilder: (BuildContext context, int index) {
            final character = party.characters[index];
            return AdventurerTile(
              character: character,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCharacterDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
