import 'package:flutter/material.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/services/note_service.dart';
import 'package:notes_sphere/services/todo_service.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:notes_sphere/widgets/main_screen_todo_card.dart';
import 'package:notes_sphere/widgets/notes_todo_card.dart';
import 'package:notes_sphere/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> allNotes = [];
  List<Todo> allTodos = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserNew();
    setState(() {});
  }

  void _checkIfUserNew() async {
    final bool isNewUser =
        await NoteService().isNewUser() || await TodoService().isNewUser();
    if (isNewUser) {
      await NoteService().createdInitialNotes();
      await TodoService().createInitialTodos();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteService().loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await TodoService().loadTodos();
    setState(() {
      allTodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteSphere",
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.kDefaultPadding,
            ),
            ProgressCard(
              completedTasks: allTodos.where((Todo) => Todo.isDone).length,
              totalTasks: allTodos.length,
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // go to the notes page
                    AppRouter.router.push("/notes");
                  },
                  child: NotesTodoCard(
                    title: "Notes",
                    description: "${allNotes.length.toString()} Notes",
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRouter.router.push("/todos");
                  },
                  child: NotesTodoCard(
                    title: "To-DO List",
                    description: "${allTodos.length.toString()} Tasks",
                    icon: Icons.today_outlined,
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's progress",
                  style: AppTextStyles.appSubtitle,
                ),
                Text(
                  "See All",
                  style: AppTextStyles.appButtonStyle,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allTodos.length,
                itemBuilder: (context, index) {
                  final Todo todo = allTodos[index];
                  print("${todo.isDone}nnn");
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: MainScreenTodoCard(
                      title: todo.title,
                      date: todo.date.toString(),
                      time: todo.time.toString(),
                      isDone: todo.isDone,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
