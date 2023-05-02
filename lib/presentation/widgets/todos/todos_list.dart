// Libraries
import 'package:flutter/material.dart';

// Project
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/presentation/widgets/todos/todo_list_item.dart';

class TodosList extends StatelessWidget {
  final List<Todo> todos;

  const TodosList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: (_, idx) => TodoListItem(todo: todos.elementAt(idx)),
    );
  }
}
