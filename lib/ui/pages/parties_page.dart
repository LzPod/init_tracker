import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/party_provider.dart';
import 'package:simple_init_tracker/models/party.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_party_dialog.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parties = ref.watch(partyProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parties'),
      ),
      body: ListView.builder(
          itemCount: parties.length,
          itemBuilder: (BuildContext context, int index) {
            return PartyTile(
              party: parties[index],
              isSelectionMode: isSelectionMode,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPartyDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
