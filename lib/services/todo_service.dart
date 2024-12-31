import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_sphere/models/todo_model.dart';

class TodoService {
  List<Todo> todos = [
    Todo(
      title: "Read a book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    Todo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];
  //create the database reference for todos
  final _myBox = Hive.box("todos");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //method to create the initial todos if the box is empty
  Future<void> createInitialTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  //method to load the todos
  Future<List<Todo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<Todo>().toList();
    }
    return [];
  }

  //mark the todo as done
  Future<void> markAsDone(Todo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element.id == todo.id);
      allTodos[index] = todo;
      await _myBox.put("todos", allTodos);
    } catch (error) {
      print(error.toString());
    }
  }

  //Method to add a note
  Future<void> addTodo(Todo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.add(todo);
      await _myBox.put("todos", allTodos);
    } catch (error) {
      print(error.toString());
    }
  }

  //Method to delete a note
  Future<void> deleteTodo(Todo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.remove(todo);
      await _myBox.put("todos", allTodos);
    } catch (error) {
      print(error.toString());
    }
  }
}
