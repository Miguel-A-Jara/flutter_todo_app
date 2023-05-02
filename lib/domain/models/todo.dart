class Todo {
  /// An auto generated uuid
  String id;
  String title;
  String description;
  bool isCompleted;
  int priority;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.priority,
    required this.description,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isCompleted = json['isCompleted'],
        priority = json['priority'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'priority': priority,
      'description': description,
    };
  }

  void toggleTodo() => isCompleted = !isCompleted;
}
