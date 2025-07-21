import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_init_tracker/models/monster.dart';

class MonsterTile extends ConsumerWidget {
  const MonsterTile({super.key, required this.monster, this.onTap});

  final Monster monster;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onTap,
      title: Text(monster.name),
    );
  }
}
