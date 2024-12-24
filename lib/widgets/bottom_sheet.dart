import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class categoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;
  const categoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<categoryInputBottomSheet> createState() =>
      _categoryInputBottomSheetState();
}

class _categoryInputBottomSheetState extends State<categoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding * 1.5),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create a new Note",
                    style: AppTextStyles.appDescriptionLargeStyle,
                  ),
                  Icon(
                    Icons.arrow_right_rounded,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.3),
              thickness: 1,
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: widget.onNewCategory,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create  new Note Category",
                      style: AppTextStyles.appDescriptionLargeStyle),
                  Icon(
                    Icons.arrow_right_rounded,
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
