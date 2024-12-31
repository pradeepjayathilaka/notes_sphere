import 'package:flutter/material.dart';
import 'package:notes_sphere/helpers/snach_bar.dart';
import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/services/todo_service.dart';
import 'package:notes_sphere/utils/router.dart';

import 'package:notes_sphere/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodos;
  final List<Todo> completedTodos;

  const TodoTab({
    super.key,
    required this.incompletedTodos,
    required this.completedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  void _markTodoAsDone(Todo todo) async {
    try {
      final Todo updatedToDo = Todo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );
      await TodoService().markAsDone(updatedToDo);

      //snackbar
      Apphelpers.showSanackBar(context, "Mark as Done");
      setState(() {
        widget.incompletedTodos.remove(todo);
        widget.completedTodos.add(updatedToDo);
      });
      AppRouter.router.go("/todos");
    } catch (error) {
      print(error.toString());
      Apphelpers.showSanackBar(context, "Failed to Mark as Done");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.incompletedTodos.sort((a, b) => a.date.compareTo(b.date));
    });
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.incompletedTodos.length,
                itemBuilder: (context, index) {
                  final Todo todo = widget.incompletedTodos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        widget.incompletedTodos.removeAt(index);
                        TodoService().deleteTodo(todo);
                      });
                      Apphelpers.showSanackBar(context, "Deleted");
                    },
                    child: TodoCard(
                      toDo: todo,
                      isCompleted: false,
                      onCheckBoxChanged: () => _markTodoAsDone(todo),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
