import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_init_tracker/core/providers/initiative_provider.dart';
import 'package:simple_init_tracker/l10n/gen_l10n/app_localizations.dart';
import 'package:simple_init_tracker/theme/colors.dart';
import 'package:simple_init_tracker/ui/animations/animated_fab.dart';
import 'package:simple_init_tracker/ui/pages/monsters_page.dart';
import 'package:simple_init_tracker/ui/pages/parties_page.dart';
import 'package:simple_init_tracker/ui/widgets/dialogs/edit_initiative.dart';
import 'package:simple_init_tracker/ui/widgets/tiles/Initiative_entity_tile.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initEntities = ref.watch(initiativeProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(AppLocalizations.of(context).appTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          if (initEntities.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                ref.read(initiativeProvider.notifier).clear();
              },
            ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.popupBackground,
        shape: RoundedRectangleBorder(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.onPopupBackground),
              child: Text(AppLocalizations.of(context).appTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            ListTile(
              leading: SizedBox(
                width: 32,
                child: SvgPicture.asset(
                  'assets/icon/adventurer_icon.svg',
                  width: 32,
                  height: 32,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              title: Text(AppLocalizations.of(context).partiesTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
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
              leading: SizedBox(
                width: 32,
                child: SvgPicture.asset(
                  'assets/icon/monster_icon.svg',
                  width: 32,
                  height: 32,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              title: Text(AppLocalizations.of(context).monstersTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
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
              leading: SizedBox(
                width: 32,
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              title: Text(AppLocalizations.of(context).settingsTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
              onTap: () {},
            ),
            ListTile(
              leading: SizedBox(
                width: 32,
                child: Icon(
                  Icons.info,
                  size: 32,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              title: Text(AppLocalizations.of(context).aboutTitle,
                  style: Theme.of(context).textTheme.headlineSmall),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: initEntities.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  'Add your first initiative entity by tapping the "+" button below.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          : ListView.builder(
              itemCount: initEntities.length,
              itemBuilder: (context, index) {
                return InitiativeEntityTile(
                  initiativeEntity: initEntities[index],
                  onDismissed: () {
                    ref.read(initiativeProvider.notifier).removeEntity(
                          initEntities[index],
                        );
                  },
                  onTap: (entity) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return EditInitiativeDialog(
                            initiativeEntity: entity,
                            onInitiativeUpdated: (newInitiative) {
                              ref
                                  .read(initiativeProvider.notifier)
                                  .updateInitiative(entity.id, newInitiative);
                            },
                          );
                        });
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
              builder: (context) => const MonstersPage(isSelectionMode: true),
            ),
          );
        },
      ),
    );
  }
}
