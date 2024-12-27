import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class NoteCategoryCard extends StatefulWidget {
  final String notTitle;
  final String notContent;
  final Future Function() removeNote;
  final Future Function() editNote;
  final void Function() viewSingleNote;
  const NoteCategoryCard({
    super.key,
    required this.notTitle,
    required this.notContent,
    required this.removeNote,
    required this.editNote,
    required this.viewSingleNote,
  });

  @override
  State<NoteCategoryCard> createState() => _NoteCategoryCardState();
}

class _NoteCategoryCardState extends State<NoteCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: widget.editNote,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: widget.removeNote,
                  icon: Icon(
                    Icons.delete_outlined,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: widget.viewSingleNote,
              child: Column(
                children: [
                  Text(
                    widget.notTitle,
                    style: AppTextStyles.appSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.notContent,
                    style: AppTextStyles.appdescriptionSmallStyle.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.5),
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
