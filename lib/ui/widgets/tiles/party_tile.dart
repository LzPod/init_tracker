import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/party.dart';
import 'package:simple_init_tracker/ui/pages/party_details_page.dart';

//TODO: Use apptheme

class PartyTile extends StatelessWidget {
  const PartyTile({
    super.key,
    required this.party,
    this.isSelectionMode = false,
    this.onLongPress,
    this.onDelete,
  });

  final Party party;
  final bool isSelectionMode;
  final VoidCallback? onLongPress;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PartyDetailsPage(
              party: party,
              isSelectionMode: isSelectionMode,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C3550),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.group,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    party.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${party.characters.length} personaggi',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.secondary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
