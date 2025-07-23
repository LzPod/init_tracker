import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:simple_init_tracker/core/providers/monsters_provider.dart';
import 'package:simple_init_tracker/models/monster.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_monster.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_monster_to_initiative.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/edit_monster_dialog.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/monster_tile.dart';

//TODO: Add search functionality for monsters

class MonstersPage extends ConsumerStatefulWidget {
  const MonstersPage({super.key, this.isSelectionMode = false});

  final bool isSelectionMode;

  @override
  ConsumerState<MonstersPage> createState() => _MonstersPageState();
}

class _MonstersPageState extends ConsumerState<MonstersPage> {
  List<dynamic> apiMonsters = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (apiMonsters.isEmpty) {
      fetchApiMonsters();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showAddMonsterDialog(BuildContext context, WidgetRef ref) async {
    final Monster? newMonster = await showDialog<Monster>(
      context: context,
      builder: (_) => const AddMonsterDialog(),
    );

    if (newMonster != null) {
      ref.read(monstersProvider.notifier).addMonster(newMonster.name);
    }
  }

  void _showAddToInitiativeDialog(Monster monster) async {
    await showDialog(
      context: context,
      builder: (_) => AddMonsterToInitiativeDialog(monster: monster),
    );
  }

  void _showEditMonsterDialog(BuildContext context, Monster monster) async {
    await showDialog<Monster>(
      context: context,
      builder: (_) => EditMonsterDialog(
        monster: monster,
        onMonsterUpdated: (newName) {
          ref
              .read(monstersProvider.notifier)
              .updateMonster(monster.id, newName);
        },
      ),
    );
  }

  void _handleApiMonsterTap(Map<String, dynamic> apiMonsterData) {
    final apiMonster = Monster(
      name: apiMonsterData['name'],
    );
    _showAddToInitiativeDialog(apiMonster);
  }

  Future<void> fetchApiMonsters() async {
    final url = Uri.parse('https://www.dnd5eapi.co/api/monsters');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          apiMonsters = data['results'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching monsters: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Monster> monsters = ref.watch(monstersProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.isSelectionMode ? 'Select Monster' : 'Monsters',
            style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search monsters',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Implement search functionality here
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('Custom monsters',
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            if (monsters.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                    "Add monsters to your collection by pressing the '+' button below.",
                    style: Theme.of(context).textTheme.bodyMedium),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: monsters.length,
                itemBuilder: (context, index) {
                  final monster = monsters[index];
                  return MonsterTile(
                    monster: monster,
                    onTap: widget.isSelectionMode
                        ? () => _showAddToInitiativeDialog(monster)
                        : null,
                    onEdit: () => _showEditMonsterDialog(context, monster),
                    onDelete: () {
                      ref
                          .read(monstersProvider.notifier)
                          .removeMonster(monster.id);
                    },
                    isCustom: true,
                  );
                },
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '5e monsters',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: apiMonsters.length,
                itemBuilder: (context, index) {
                  final monster = apiMonsters[index];
                  return MonsterTile(
                    monster: Monster(name: monster['name']),
                    onTap: widget.isSelectionMode
                        ? () => _handleApiMonsterTap(monster)
                        : null,
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMonsterDialog(context, ref),
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
