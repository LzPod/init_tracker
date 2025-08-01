import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_init_tracker/l10n/gen_l10n/app_localizations.dart';
import 'package:simple_init_tracker/theme/app_theme.dart';
import 'package:simple_init_tracker/theme/colors.dart';
import 'package:simple_init_tracker/ui/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //TODO: Add Tour

  await Hive.openBox('partiesBox');
  await Hive.openBox('monstersBox');
  await Hive.openBox('apiMonstersBox');

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppColors.background,
      systemNavigationBarColor: AppColors.background,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.background,
      systemNavigationBarColor: AppColors.background,
    ),
  );

  runApp(const ProviderScope(
    child: InitTrackerApp(),
  ));
}

class InitTrackerApp extends StatelessWidget {
  const InitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Initiative Tracker',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('it'), // Italian
      ],
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainPage(),
    );
  }
}
