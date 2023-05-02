// Flutter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Project
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/presentation/screens/screens.dart';
import 'package:todo_app/presentation/layouts/main_todo_layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class MainRouter {
  static GoRouter get router => _router;

  static final _router = GoRouter(
      initialLocation: MainRoutesTypes.todosPage.value,
      navigatorKey: _rootNavigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (_, __, child) => MainTodoLayout(body: child),
          routes: [
            GoRoute(
              path: MainRoutesTypes.todosPage.value,
              pageBuilder: (_, state) => _customTransitionPage(
                state: state,
                child: const TodosScreen(),
              ),
            ),
            GoRoute(
              path: MainRoutesTypes.addTodo.value,
              pageBuilder: (_, state) => _customTransitionPage(
                state: state,
                child: const AddTodoScreen(),
              ),
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '${MainRoutesTypes.reviewTodo.value}/:todoId',
          pageBuilder: (_, state) => _customTransitionPage(
            state: state,
            child: const ReviewTodoScreen(),
          ),
        )
      ]);

  static _customTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (_, animation, __, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
