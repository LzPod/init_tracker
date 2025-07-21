import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/party.dart';
import 'package:simple_init_tracker/ui/pages/party_details_page.dart';

class PartyTile extends StatelessWidget {
  const PartyTile(
      {super.key, required this.party, this.isSelectionMode = false});

  final Party party;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(party.name),
        subtitle: Text(
          party.characters.isEmpty
              ? 'No characters in this party'
              : '${party.characters.length} character(s)',
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PartyDetailsPage(
                  partyId: party.id, isSelectionMode: isSelectionMode),
            ),
          );
        });
  }
}
