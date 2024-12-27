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
}
