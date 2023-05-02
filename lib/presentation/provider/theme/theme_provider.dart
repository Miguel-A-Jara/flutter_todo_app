// Interface
import 'package:flutter/material.dart';
import 'package:todo_app/data/user_preferences/user_preferences_keys.dart';

// Project
import 'package:todo_app/data/user_preferences/user_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static final prefs = UserPreferences.prefs;

  bool get isDarkTheme => _isDarkTheme;
  bool _isDarkTheme =
      prefs.getBool(UserPreferencesKeys.isDarkTheme.name) ?? false;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    prefs.setBool(UserPreferencesKeys.isDarkTheme.name, _isDarkTheme);
    notifyListeners();
  }
}
