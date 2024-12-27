import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class completedTab extends StatefulWidget {
  const completedTab({super.key});

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
