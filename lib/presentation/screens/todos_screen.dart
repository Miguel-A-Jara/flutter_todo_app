// Libraries
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Project
import 'package:todo_app/presentation/widgets/todos/todos_list.dart';
import 'package:todo_app/presentation/provider/todos/todos_provider.dart';
import 'package:todo_app/presentation/widgets/common/page_background.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todosProvider = context.watch<TodosProvider>();

    return PageBackground(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TodosList(
          todos: todosProvider.todos,
        ),
      ),
    );
  }
}
