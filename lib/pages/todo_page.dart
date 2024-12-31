import 'package:flutter/material.dart';
import 'package:notes_sphere/helpers/snach_bar.dart';
import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/services/todo_service.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:notes_sphere/widgets/completed_tab.dart';
import 'package:notes_sphere/widgets/todo_tab.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Todo> allTodos = [];
  late List<Todo> incompletedTodos = [];
  late List<Todo> completedTodos = [];
  TodoService todoService = TodoService();
  TextEditingController _taskController = TextEditingController();

  void dispose() {
    _tabController.dispose();
    _taskController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    if (isNewUser) {
      await todoService.createInitialTodos();
    }
    _loadToDos();
  }

  Future<void> _loadToDos() async {
    final List<Todo> loadedTodos = await todoService.loadTodos();
    setState(() {
      allTodos = loadedTodos;

      //incompleted todos
      incompletedTodos = allTodos.where((todo) => !todo.isDone).toList();
      //completed todos
      completedTodos = allTodos.where((todo) => todo.isDone).toList();
    });
  }

  //method to add task
  void _addTask() async {
    try {
      if (_taskController.text.isNotEmpty) {
        final Todo newTodo = Todo(
          title: _taskController.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );
        await todoService.addTodo(newTodo);
        setState(() {
          allTodos.add(newTodo);
          incompletedTodos.add(newTodo);
        });
        Apphelpers.showSanackBar(context, "Task Added Successfully");
        Navigator.pop(context);
      }
    } catch (error) {
      Apphelpers.showSanackBar(context, "Failed to add Task");
    }
  }

  void openMesssageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Add Task",
              style: AppTextStyles.appDescriptionLargeStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _taskController,
              style: TextStyle(
                color: AppColors.kWhiteColor,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: "Enter Your Task",
                hintStyle: AppTextStyles.appdescriptionSmallStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  AppColors.kFaBColor,
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: Text(
                "Add Task",
                style: AppTextStyles.appButtonStyle,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  AppColors.kCardColor,
                ),
              ),
              child: Text("Cancel", style: AppTextStyles.appButtonStyle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            AppRouter.router.go("/");
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                "ToDo",
                style: AppTextStyles.appDescriptionLargeStyle,
              ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescriptionLargeStyle,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openMesssageModel(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          weight: 30,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoTab(
            incompletedTodos: incompletedTodos,
            completedTodos: completedTodos,
          ),
          CompletdTab(
            completedTodos: completedTodos,
            incompletedTodos: incompletedTodos,
          ),
        ],
      ),
    );
  }
}
