import 'package:flutter/material.dart';
import 'package:simple_init_tracker/models/party.dart';

class PartyTile extends StatelessWidget {
  const PartyTile({super.key, required this.party});

  final Party party;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(party.name),
      subtitle: Text(
        party.characters.isEmpty
            ? 'No characters in this party'
            : '${party.characters.length} character(s)',
      ),
    );
  }
}
