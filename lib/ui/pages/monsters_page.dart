import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:simple_init_tracker/core/providers/monsters_provider.dart';
import 'package:simple_init_tracker/models/monster.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_monster.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/add_monster_to_initiative.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/monster_tile.dart';

class MonstersPage extends ConsumerStatefulWidget {
  const MonstersPage({super.key, this.isSelectionMode = false});

  final bool isSelectionMode;

  @override
  ConsumerState<MonstersPage> createState() => _MonstersPageState();
}

class _MonstersPageState extends ConsumerState<MonstersPage> {
  List<dynamic> apiMonsters = [];
  bool isLoading = true;

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

  void _handleApiMonsterTap(Map<String, dynamic> apiMonsterData) {
    // Converti il mostro dall'API in un Monster object
    final apiMonster = Monster(
      name: apiMonsterData['name'],
      // Qui potresti aggiungere altri dati se disponibili dall'API
      // Per ora usiamo valori di default
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
        title: Text(widget.isSelectionMode ? 'Select Monster' : 'Monsters'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Custom monsters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            if (monsters.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Add monsters to your collection by pressing the '+' button below."),
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
                  );
                },
              ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '5e monsters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  return ListTile(
                    title: Text(monster['name']),
                    trailing: widget.isSelectionMode
                        ? const Icon(Icons.arrow_forward_ios)
                        : null,
                    onTap: widget.isSelectionMode
                        ? () => _handleApiMonsterTap(monster)
                        : null,
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: widget.isSelectionMode
          ? null
          : FloatingActionButton(
              onPressed: () {
                _showAddMonsterDialog(context, ref);
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
