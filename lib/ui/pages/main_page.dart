import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/core/providers/character_provider.dart';
import 'package:simple_init_tracker/ui/animations/animated_fab.dart';
import 'package:simple_init_tracker/ui/pages/monsters_page.dart';
import 'package:simple_init_tracker/ui/pages/parties_page.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/character_tile.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(characterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Initiative Tracker'),
        actions: [
          if (characters.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(characterProvider.notifier).clearCharacters();
              },
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Adventurers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PartiesPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_card_sharp),
              title: const Text('Monsters'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MonstersPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: characters.isEmpty
          ? Center(
              child: Text(
                'characters.isEmpty',
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
      floatingActionButton: AnimatedFab(
        onAddCharacter: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PartiesPage(isSelectionMode: true),
            ),
          );
        },
        onAddMonster: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MonstersPage(),
            ),
          );
        },
      ),
    );
  }
}
