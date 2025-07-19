import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartiesPage extends ConsumerWidget {
  const PartiesPage({super.key});

  // ref.read is used to read the state of a provider.
  // ref.watch is used to listen to the state of a provider.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parties'),
      ),
      body: Center(
        child: Text(
          'This is the Parties Page',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
