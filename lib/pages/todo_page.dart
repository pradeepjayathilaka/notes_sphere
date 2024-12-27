import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        onPressed: () {},
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
          TodoTab(),
          completedTab(),
        ],
      ),
    );
  }
}
