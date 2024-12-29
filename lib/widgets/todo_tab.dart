import 'package:flutter/material.dart';
import 'package:notes_sphere/models/todo_model.dart';

import 'package:notes_sphere/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodos;
  const TodoTab({
    super.key,
    required this.incompletedTodos,
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
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
                  final Todo toDo = widget.incompletedTodos[index];
                  return TodoCard(
                    toDo: toDo,
                    isCompleted: false,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
