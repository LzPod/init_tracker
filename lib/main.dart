import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_init_tracker/theme/app_theme.dart';
import 'package:simple_init_tracker/ui/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('partiesBox');
  await Hive.openBox('monstersBox');

  runApp(const ProviderScope(
    child: InitTrackerApp(),
  ));
}

class InitTrackerApp extends StatelessWidget {
  const InitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Init Tracker',
      //TODO: add lightTheme
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainPage(),
    );
  }
}
