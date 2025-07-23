import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/party_provider.dart';
import 'package:simple_init_tracker/models/party.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_party_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/edit_party_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/party_tile.dart';

class PartiesPage extends ConsumerWidget {
  const PartiesPage({super.key, this.isSelectionMode = false});

  final bool isSelectionMode;

  void _showAddPartyDialog(BuildContext context, WidgetRef ref) async {
    final Party? newParty = await showDialog<Party>(
      context: context,
      builder: (_) => const AddPartyDialog(),
    );

    if (newParty != null) {
      ref.read(partyProvider.notifier).addParty(newParty.name);
    }
  }

  void _showEditPartyDialog(
      BuildContext context, WidgetRef ref, Party party) async {
    await showDialog<Party>(
      context: context,
      builder: (_) => EditPartyDialog(
        party: party,
        onPartyUpdated: (party) {
          ref.read(partyProvider.notifier).updateParty(party);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parties = ref.watch(partyProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Parties',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: ListView.builder(
          itemCount: parties.length,
          itemBuilder: (BuildContext context, int index) {
            return PartyTile(
              party: parties[index],
              isSelectionMode: isSelectionMode,
              onLongPress: () {
                _showEditPartyDialog(context, ref, parties[index]);
              },
              onDelete: () {
                ref.read(partyProvider.notifier).removeParty(parties[index].id);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPartyDialog(context, ref),
        child: SizedBox(
          width: 32,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.secondary,
            size: 32,
          ),
        ),
      ),
    );
  }
}
