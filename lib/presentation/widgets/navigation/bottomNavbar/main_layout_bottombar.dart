// Libraries
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Project
import 'package:todo_app/config/routes/routes.dart';

class BottomBarItemProp {
  final IconData icon;
  final MainRoutesTypes route;
  final String label;

  const BottomBarItemProp({
    required this.icon,
    required this.route,
    required this.label,
  });
}

class MainLayoutBottomBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomBarItemProp> navbarItems;

  const MainLayoutBottomBar({
    super.key,
    required this.currentIndex,
    required this.navbarItems,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.shifting,
      onTap: (idx) => context.go(navbarItems.elementAt(idx).route.value),
      items: navbarItems
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
              backgroundColor: currentIndex.isEven
                  ? colors.primary
                  : colors.primaryContainer,
            ),
          )
          .toList(),
    );
  }
}
