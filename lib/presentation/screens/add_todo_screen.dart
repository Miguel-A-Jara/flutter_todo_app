// Libraries

import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/todos/todo_form.dart';

// Project
import 'package:todo_app/presentation/widgets/common/page_background.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return PageBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Add a Todo', style: textStyle.headlineLarge),
          const SizedBox(height: 20),
          const TodoForm(),
        ],
      ),
    );
  }
}
