// Libraries
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Project
import 'package:todo_app/config/theme/main_theme.dart';
import 'package:todo_app/config/routes/main_router.dart';
import 'package:todo_app/presentation/provider/providers.dart';
import 'package:todo_app/data/user_preferences/user_preferences.dart';
import 'package:todo_app/presentation/provider/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();

  runApp(Providers.initialize(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkTheme;

    return MaterialApp.router(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      routerConfig: MainRouter.router,
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      themeAnimationDuration: const Duration(seconds: 1),
      themeAnimationCurve: Curves.easeOutQuart,
    );
  }
}
