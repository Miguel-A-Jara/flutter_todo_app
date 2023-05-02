// Libraries

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/routes/routes.dart';

// Project
import 'package:todo_app/domain/models/todo.dart';
import 'package:todo_app/presentation/provider/todos/todos_provider.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final todosProvider = context.read<TodosProvider>();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(),
        secondaryBackground: const _SecondaryBackground(),
        onDismissed: (_) => todosProvider.deleteTodo(todo.id),
        key: UniqueKey(),
        child: _CustomTile(todo),
      ),
    );
  }
}

class _SecondaryBackground extends StatelessWidget {
  const _SecondaryBackground();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: colors.error,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [Icon(Icons.delete, color: Colors.white)],
      ),
    );
  }
}

class _CustomTile extends StatefulWidget {
  final Todo todo;
  const _CustomTile(this.todo);

  @override
  State<_CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<_CustomTile> {
  void toggleTodo() {
    widget.todo.toggleTodo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.headlineSmall!;
    final todoRoute = '${MainRoutesTypes.reviewTodo.value}/${widget.todo.id}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [colors.primary, colors.primaryContainer],
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _TodoPriorityColor(priority: widget.todo.priority),
            _CustomSwitch(
              isCompleted: widget.todo.isCompleted,
              onChanged: toggleTodo,
            ),
            Expanded(
              child: Text(
                widget.todo.title,
                style: textStyle.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            IconButton(
              onPressed: () => context.push(todoRoute),
              icon: const Icon(Icons.arrow_forward, size: 25),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onChanged;

  const _CustomSwitch({required this.isCompleted, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isCompleted,
      onChanged: (_) => onChanged(),
    );
  }
}

class _TodoPriorityColor extends StatelessWidget {
  final int priority;

  const _TodoPriorityColor({
    required this.priority,
  });

  static const _priorityLevels = {
    1: Colors.redAccent,
    2: Colors.deepOrange,
    3: Colors.yellowAccent,
    4: Colors.limeAccent,
    5: Colors.green
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _priorityLevels[priority],
      width: 5,
      margin: const EdgeInsets.only(right: 10),
    );
  }
}
