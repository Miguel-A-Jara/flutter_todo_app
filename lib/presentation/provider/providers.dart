// Third Party
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Project
import 'package:todo_app/presentation/provider/theme/theme_provider.dart';
import 'package:todo_app/presentation/provider/todos/todos_provider.dart';

class Providers {
  static Widget initialize({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TodosProvider()),
      ],
      child: child,
    );
  }
}
