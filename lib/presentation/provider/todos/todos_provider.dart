// Dart
import 'dart:convert';

// Libraries
import 'package:todo_app/data/user_preferences/user_preferences.dart';
import 'package:todo_app/data/user_preferences/user_preferences_keys.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

// Project
import 'package:todo_app/domain/models/todo.dart';

class TodosProvider extends ChangeNotifier {
  final uuid = const Uuid();
  static final _localTodos = UserPreferences.prefs.getString(
    UserPreferencesKeys.todosList.name,
  );

  static final decodedLocalData =
      _localTodos != null ? (json.decode(_localTodos!)) as List<dynamic> : [];

  List<Todo> _todos = decodedLocalData.map((e) => Todo.fromJson(e)).toList();
  List<Todo> get todos => _todos;
  dynamic randomValue = decodedLocalData;

  // This is a really bad approach. This is exactly what the
  // "data" layer is for. But I'm doing this because I haven't slept in almost 2 days
  void _updateLocalTodos() {
    final prefs = UserPreferences.prefs;

    prefs.setString(
      UserPreferencesKeys.todosList.name,
      json.encode(_todos),
    );
  }

  void addTodo({
    required String title,
    required String description,
    required int priority,
  }) {
    if (priority <= 0 || priority > 5) {
      throw Exception('The value must be between 0 and 5');
    }

    final todoId = uuid.v4();

    final newTodo = Todo(
      id: todoId,
      title: title,
      priority: priority,
      isCompleted: false,
      description: description,
    );

    _todos.add(newTodo);
    _updateLocalTodos();
    notifyListeners();
  }

  void toggleTodo(String todoId) {
    for (var todo in _todos) {
      todo.id == todoId ? todo.toggleTodo() : todo;
    }
    _updateLocalTodos();
  }

  Todo getTodoById(String todoId) {
    return _todos.firstWhere((todo) => todo.id == todoId);
  }

  void deleteTodo(String todoId) {
    _todos = _todos.where((todo) => todo.id != todoId).toList();
    _updateLocalTodos();
  }
}
