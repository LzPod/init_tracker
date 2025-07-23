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

class MonstersPage extends ConsumerStatefulWidget {
  const MonstersPage({super.key, this.isSelectionMode = false});

  final bool isSelectionMode;

  @override
  ConsumerState<MonstersPage> createState() => _MonstersPageState();
}

class _MonstersPageState extends ConsumerState<MonstersPage> {
  List<dynamic> apiMonsters = [];
  List<dynamic> filteredApiMonsters = [];
  List<Monster> filteredCustomMonsters = [];
  bool isLoading = true;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchApiMonsters();
    filteredCustomMonsters = ref.read(monstersProvider);
    searchController.addListener(() {
      final query = searchController.text;
      filterMonsters(query);
      setState(() {});
    });
  }

  void _showAddMonsterDialog(BuildContext context, WidgetRef ref) async {
    final Monster? newMonster = await showDialog<Monster>(
      context: context,
      builder: (_) => const AddMonsterDialog(),
    );

    if (newMonster != null) {
      ref.read(monstersProvider.notifier).addMonster(newMonster.name);
    }

    filterMonsters(searchController.text);
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
    filterMonsters(searchController.text);
  }

  void deleteMonster(String id) {
    ref.read(monstersProvider.notifier).removeMonster(id);
    filterMonsters(searchController.text);
  }

  void _handleApiMonsterTap(Map<String, dynamic> apiMonsterData) {
    final apiMonster = Monster(
      name: apiMonsterData['name'],
    );
    _showAddToInitiativeDialog(apiMonster);
  }

  Future<void> fetchApiMonsters() async {
    final url = Uri.parse('https://www.dnd5eapi.co/api/monsters');
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          apiMonsters = data['results'];
          filteredApiMonsters = apiMonsters;
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

  void filterMonsters(String query) {
    filteredApiMonsters = apiMonsters.where((monster) {
      final name = monster['name'].toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
    filteredCustomMonsters = ref
        .watch(monstersProvider)
        .where((monster) =>
            monster.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final customMonsters = ref.watch(monstersProvider);
    print(
        'Custom Monsters: ${customMonsters.length}, filtered: ${filteredCustomMonsters.length}');
    final bool hasCustomMonsters =
        customMonsters.isNotEmpty && filteredCustomMonsters.isEmpty;
    print('Has Custom Monsters: $hasCustomMonsters');
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
            if (filteredCustomMonsters.isNotEmpty ||
                searchController.text == '')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Custom monsters',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            if (customMonsters.isEmpty && searchController.text == '')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                    "Add monsters to your collection by pressing the '+' button below.",
                    style: Theme.of(context).textTheme.bodyMedium),
              )
            else if (customMonsters.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredCustomMonsters.length,
                itemBuilder: (context, index) {
                  final monster = filteredCustomMonsters[index];
                  return MonsterTile(
                    monster: monster,
                    onTap: widget.isSelectionMode
                        ? () => _showAddToInitiativeDialog(monster)
                        : null,
                    onEdit: () => _showEditMonsterDialog(context, monster),
                    onDelete: () {
                      deleteMonster(monster.id);
                    },
                    isCustom: true,
                  );
                },
              ),
            if (filteredCustomMonsters.isNotEmpty &&
                    filteredApiMonsters.isNotEmpty ||
                searchController.text == '')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            if (filteredApiMonsters.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
                itemCount: filteredApiMonsters.length,
                itemBuilder: (context, index) {
                  final monster = filteredApiMonsters[index];
                  return MonsterTile(
                    monster: Monster(name: monster['name']),
                    onTap: widget.isSelectionMode
                        ? () => _handleApiMonsterTap(monster)
                        : null,
                  );
                },
              ),
            if (filteredApiMonsters.isEmpty &&
                filteredCustomMonsters.isEmpty &&
                !isLoading)
              Center(
                child: Text('No monsters found.',
                    style: Theme.of(context).textTheme.headlineSmall),
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
