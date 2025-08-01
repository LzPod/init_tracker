import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_init_tracker/models/monster.dart';

class MonsterTile extends ConsumerWidget {
  const MonsterTile({
    super.key,
    required this.monster,
    this.isCustom = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Monster monster;
  final bool isCustom;
  final void Function()? onTap;
  final void Function()? onEdit;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap ?? onEdit,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icon/monster_icon.svg',
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                monster.name,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isCustom)
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.close,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20)),
          ],
        ),
      ),
    );
  }
}
