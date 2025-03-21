import 'package:flutter/material.dart';
import 'package:notes_sphere/models/todo_model.dart';

class ToDoData extends InheritedWidget {
  final List<Todo> todos;
  final Function() onTodosChanged;

  ToDoData(
      {super.key,
      required super.child,
      required this.todos,
      required this.onTodosChanged});

  static ToDoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ToDoData>();
  }

  @override
  bool updateShouldNotify(covariant ToDoData oldWidget) {
    return todos != oldWidget.todos;
  }
}
