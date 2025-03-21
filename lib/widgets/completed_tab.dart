import 'package:flutter/material.dart';
import 'package:notes_sphere/helpers/snach_bar.dart';

import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/pages/todo_inharited_widget.dart';
import 'package:notes_sphere/services/todo_service.dart';

import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/widgets/todo_card.dart';

class CompletdTab extends StatefulWidget {
  final List<Todo> completedTodos;
  final List<Todo> incompletedTodos;
  const CompletdTab({
    super.key,
    required this.completedTodos,
    required this.incompletedTodos,
  });

  @override
  State<CompletdTab> createState() => _CompletdTabState();
}

class _CompletdTabState extends State<CompletdTab> {
  void _markTodoAsUnDone(Todo todo) async {
    try {
      final Todo updatedTodo = Todo(
        id: todo.id,
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );
      Apphelpers.showSanackBar(context, "Marked as UnDone");
      await TodoService().markAsDone(updatedTodo);
      setState(() {
        widget.completedTodos.remove(todo);
        widget.incompletedTodos.add(todo);
      });

      AppRouter.router.go("/todos");
    } catch (error) {
      Apphelpers.showSanackBar(context, "Failed to Mark as UnDone");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodos.sort((a, b) => a.date.compareTo(b.date));
    });
    return ToDoData(
      todos: widget.completedTodos,
      onTodosChanged: () {},
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.completedTodos.length,
                  itemBuilder: (context, index) {
                    final Todo toDo = widget.completedTodos[index];
                    return TodoCard(
                      toDo: toDo,
                      isCompleted: true,
                      onCheckBoxChanged: () => _markTodoAsUnDone(toDo),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
