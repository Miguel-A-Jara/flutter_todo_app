// Dart
import 'dart:ui';

// Flutter
import 'package:flutter/material.dart';

// Third Party
import 'package:provider/provider.dart';

// Project
import 'package:todo_app/presentation/provider/theme/theme_provider.dart';

class MainLayoutAppbar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  const MainLayoutAppbar({
    required this.context,
    super.key,
    this.title = 'Todo App',
  });

  @override
  Size get preferredSize {
    final size = MediaQuery.of(context).size;
    return Size(size.width, size.height * 0.075);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.colorScheme.secondary,
            theme.colorScheme.primaryContainer
          ],
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: IntrinsicHeight(
                child: _NavbarElements(title: title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavbarElements extends StatelessWidget {
  final String title;
  const _NavbarElements({required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colors = Theme.of(context).colorScheme;

    final textStyle = Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontWeight: FontWeight.w300);

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(title, style: textStyle, textAlign: TextAlign.center),
        Positioned(
          right: 5,
          child: IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: AnimatedCrossFade(
              crossFadeState: themeProvider.isDarkTheme
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 500),
              firstChild: const Icon(Icons.light_mode, color: Colors.white),
              secondChild: const Icon(Icons.dark_mode, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
