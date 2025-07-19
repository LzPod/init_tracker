import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/character.dart';
import 'package:simple_init_tracker/ui/widgets/add_character_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/character_tile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Character> characters = [];

  void _sortCharacters() {
    characters.sort((a, b) {
      if (a.initiative != b.initiative) {
        return b.initiative.compareTo(a.initiative);
      } else {
        //TODO: handle tie-breakers
        return a.name.compareTo(b.name);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _showAddCharacterDialog() async {
    final Character? newCharacter = await showDialog<Character>(
      context: context,
      builder: (BuildContext context) {
        return const AddCharacterDialog();
      },
    );

    if (newCharacter != null) {
      setState(() {
        characters.add(newCharacter);
        _sortCharacters();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCharacterDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
