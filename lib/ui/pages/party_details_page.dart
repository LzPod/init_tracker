import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/character_provider.dart';
import 'package:simple_init_tracker/core/providers/initiative_provider.dart';
import 'package:simple_init_tracker/core/providers/party_provider.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/models/party.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_adventurer_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/edit_adventurer_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/adventurer_tile.dart';

import 'main_page.dart';

class PartyDetailsPage extends ConsumerStatefulWidget {
  const PartyDetailsPage({
    super.key,
    required this.party,
    this.isSelectionMode = false,
  });

  final Party party;
  final bool isSelectionMode;

  @override
  ConsumerState<PartyDetailsPage> createState() => _PartyDetailPageState();
}

class _PartyDetailPageState extends ConsumerState<PartyDetailsPage> {
  final Set<Character> _selectedCharacters = {};

  void _toggleCharacterSelection(Character character) {
    setState(() {
      if (_selectedCharacters.contains(character)) {
        _selectedCharacters.remove(character);
      } else {
        _selectedCharacters.add(character);
      }
    });
  }

  void _addSelectedToInitiative() {
    for (final character in _selectedCharacters) {
      ref.read(initiativeProvider.notifier).addEntity(character);
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainPage()),
      (route) => false,
    );
  }

  void _showAddCharacterDialog(BuildContext context, WidgetRef ref) async {
    final Character? newCharacter = await showDialog<Character>(
      context: context,
      builder: (_) => const AddAdventurerDialog(),
    );

    print('New character: ${newCharacter?.name}');

    if (newCharacter != null) {
      ref.read(partyProvider.notifier).addCharacterToParty(
            ref.read(partyProvider).firstWhere((p) => p.id == widget.party.id),
            newCharacter,
          );
    }
  }

  void _showEditAdventurerDialog(
      BuildContext context, Character character) async {
    await showDialog<Character>(
      context: context,
      builder: (_) => EditAdventurerDialog(
        adventurer: character,
        onAdventurerUpdated: (character) {
          ref.read(characterProvider.notifier).updateCharacter(character);
          ref
              .read(partyProvider.notifier)
              .editCharacterInParty(widget.party.id, character);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parties = ref.watch(partyProvider);
    final currentParty = parties.firstWhere(
      (p) => p.id == widget.party.id,
      orElse: () => widget.party,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(currentParty.name,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: currentParty.characters.isEmpty
                    ? const Center(
                        child: Text('Nessun personaggio in questo party'),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(
                          bottom: widget.isSelectionMode &&
                                  _selectedCharacters.isNotEmpty
                              ? 80.0
                              : 0,
                        ),
                        itemCount: currentParty.characters.length,
                        itemBuilder: (context, index) {
                          final character = currentParty.characters[index];
                          return AdventurerTile(
                            character: character,
                            isSelectable: widget.isSelectionMode,
                            isSelected: _selectedCharacters.contains(character),
                            onTap: widget.isSelectionMode
                                ? () => _toggleCharacterSelection(character)
                                : null,
                            onEdit: () => _showEditAdventurerDialog(
                              context,
                              character,
                            ),
                            onDelete: () {
                              ref
                                  .read(characterProvider.notifier)
                                  .removeCharacter(
                                    character.id,
                                  );
                              ref
                                  .read(partyProvider.notifier)
                                  .removeCharacterFromParty(
                                    widget.party.id,
                                    character.id,
                                  );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          if (widget.isSelectionMode && _selectedCharacters.isNotEmpty)
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 88.0,
              child: ElevatedButton(
                onPressed: _addSelectedToInitiative,
                child: Text(
                  'Aggiungi ${_selectedCharacters.length} ${_selectedCharacters.length == 1 ? 'personaggio' : 'personaggi'}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCharacterDialog(context, ref);
        },
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
