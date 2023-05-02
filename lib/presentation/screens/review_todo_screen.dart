// Libraries
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Project
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/presentation/provider/todos/todos_provider.dart';
import 'package:todo_app/presentation/widgets/common/page_background.dart';

class ReviewTodoScreen extends StatelessWidget {
  const ReviewTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final params = GoRouterState.of(context).pathParameters;
    final todosProvider = context.read<TodosProvider>();

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final todoId = params['todoId'];
    if (todoId == null) {
      context.replace(MainRoutesTypes.todosPage.value);
    }

    final todo = todosProvider.getTodoById(todoId!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.secondary,
      ),
      body: PageBackground(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(todo.title, style: textTheme.headlineLarge),
              _PriorityAndStatus(
                todo: todo,
                onChange: () => todosProvider.toggleTodo(todo.id),
              ),
              Text(todo.description, style: textTheme.bodyLarge),
            ],
          ),
        ),
      )),
    );
  }
}

class _PriorityAndStatus extends StatefulWidget {
  final Todo todo;
  final VoidCallback onChange;
  const _PriorityAndStatus({required this.todo, required this.onChange});

  @override
  State<_PriorityAndStatus> createState() => _PriorityAndStatusState();
}

class _PriorityAndStatusState extends State<_PriorityAndStatus> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: [
          Text('Priority: ', style: textTheme.titleMedium),
          Text('${widget.todo.priority}', style: textTheme.titleLarge),
        ]),
        Switch.adaptive(
          value: widget.todo.isCompleted,
          onChanged: (_) {
            widget.onChange();
            setState(() {});
          },
        )
      ],
    );
  }
}
