import 'package:flutter/material.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widget/notes_todo_card.dart';
import 'package:note_sphere/widget/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notesphere",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.kDefaultpadding,
            ),
            ProgressCard(
              completedTasks: 2,
              totalTasks: 5,
            ),
            SizedBox(
              height: AppConstants.kDefaultpadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NotesTodoCard(
                  title: "Nots",
                  description: "3 nots",
                  icon: Icons.bookmark_add_outlined,
                ),
                NotesTodoCard(
                  title: "To-Do List",
                  description: "3 Tasks",
                  icon: Icons.today_outlined,
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kDefaultpadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's progress",
                  style: AppTextStyles.appsubTitle,
                ),
                Text(
                  "Seee All",
                  style: AppTextStyles.appButton,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
