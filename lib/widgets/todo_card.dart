import 'package:flutter/material.dart';
import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class TodoCard extends StatefulWidget {
  final Todo toDo;
  final bool isCompleted;
  const TodoCard({
    super.key,
    required this.toDo,
    required this.isCompleted,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          widget.toDo.title,
          style: AppTextStyles.appDescriptionLargeStyle,
        ),
        subtitle: Row(
          children: [
            Text(
              "${widget.toDo.date.day}/${widget.toDo.date.month}/${widget.toDo.date.year}",
              style: AppTextStyles.appdescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${widget.toDo.time.hour}:${widget.toDo.time.minute}",
              style: AppTextStyles.appdescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (value) {},
        ),
      ),
    );
  }
}
