import 'package:flutter/material.dart';

class MainTheme {
  static ThemeData get lightTheme => _lightTheme;

  static final _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.cyanAccent,
      primaryContainer: Colors.cyanAccent.shade700,
      secondary: Colors.lightBlueAccent,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        return states.contains(MaterialState.selected)
            ? Colors.white
            : Colors.cyanAccent;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        return states.contains(MaterialState.selected)
            ? Colors.lightBlueAccent
            : Colors.white;
      }),
    ),
  );

  static ThemeData get darkTheme => _darkTheme;

  static final _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: Colors.indigo,
      primaryContainer: Colors.indigoAccent,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        return states.contains(MaterialState.selected)
            ? Colors.white
            : Colors.indigoAccent;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        return states.contains(MaterialState.selected)
            ? Colors.indigoAccent
            : Colors.white;
      }),
    ),
  );
}
