import 'package:flutter/material.dart';
import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class completedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  const completedTab({
    super.key,
    required this.completedTodos,
  });

  @override
  State<completedTab> createState() => _completedTabState();
}

class _completedTabState extends State<completedTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Completd Tab", style: AppTextStyles.appBody),
    );
  }
}
