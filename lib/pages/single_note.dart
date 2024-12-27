import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class SingleNotePage extends StatefulWidget {
  final Note note;
  const SingleNotePage({
    super.key,
    required this.note,
  });

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    //formatted date
    final formatedDate = DateFormat.yMMMd().format(widget.note.date);
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          AppConstants.kDefaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.title,
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.note.category,
              style: AppTextStyles.appButtonStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              formatedDate,
              style: AppTextStyles.appdescriptionSmallStyle.copyWith(
                color: AppColors.kFaBColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.content,
              style: AppTextStyles.appDescriptionLargeStyle.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
