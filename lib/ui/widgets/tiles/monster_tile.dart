import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/models/monster.dart';

class MonsterTile extends ConsumerWidget {
  const MonsterTile({super.key, required this.monster});

  final Monster monster;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        // TODO: Implement edit character functionality
      },
      title: Text(monster.name),
    );
  }
}
