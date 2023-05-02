// Flutter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Project
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/presentation/widgets/navigation/appbar/main_layout_appbar.dart';
import 'package:todo_app/presentation/widgets/navigation/bottomNavbar/main_layout_bottombar.dart';

const List<BottomBarItemProp> bottomNavbarRoutes = [
  BottomBarItemProp(
    icon: Icons.newspaper,
    route: MainRoutesTypes.todosPage,
    label: 'Todos',
  ),
  BottomBarItemProp(
    icon: Icons.add,
    route: MainRoutesTypes.addTodo,
    label: 'Add Todo',
  ),
];

class MainTodoLayout extends StatelessWidget {
  /// A widget that implements PreferredSizeWidget
  /// ```
  /// class MyCustomNavbar extends StatlessWidget implements PreferredSizeWidget {}
  /// ```
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  final int currentBottomBarIndex = 0;

  const MainTodoLayout({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    int currentBottomBarIndex() {
      final currentPage = GoRouterState.of(context).location;
      final BottomBarItemProp currentItem = bottomNavbarRoutes
          .firstWhere((item) => item.route.value == currentPage);
      return bottomNavbarRoutes.indexOf(currentItem);
    }

    return Scaffold(
      appBar: appBar ?? MainLayoutAppbar(context: context),
      body: body,
      bottomNavigationBar: bottomNavigationBar ??
          MainLayoutBottomBar(
            currentIndex: currentBottomBarIndex(),
            navbarItems: bottomNavbarRoutes,
          ),
    );
  }
}
