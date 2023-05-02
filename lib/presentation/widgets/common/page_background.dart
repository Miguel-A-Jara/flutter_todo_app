import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  final Widget child;

  const PageBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          colors.primaryContainer.withOpacity(0.7),
          colors.primary.withOpacity(0.5),
        ]),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
