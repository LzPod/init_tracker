import 'package:flutter/material.dart';
import 'package:simple_init_tracker/ui/pages/main_page.dart';

void main() {
  runApp(const InitTrackerApp());
}

class InitTrackerApp extends StatelessWidget {
  const InitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Init Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
