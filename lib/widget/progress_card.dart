import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/text_styles.dart';

class ProgressCard extends StatefulWidget {
  final int completedTasks;
  final int totalTasks;
  const ProgressCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    //calculation for the completionPrecentation
    double completionPrecentation = widget.totalTasks != 0
        ? (widget.completedTasks / widget.totalTasks) * 100
        : 0;

    return Container(
      padding: EdgeInsets.all(AppConstants.kDefaultpadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.kCardColor,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appTitle,
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  "You have completed${widget.completedTasks} out of${widget.totalTasks}tasks \n keep the progress,",
                  style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.19,
                height: MediaQuery.of(context).size.width * 0.19,
                decoration: BoxDecoration(
                  gradient: AppColors().kPrimaryGradient,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  "${completionPrecentation}%",
                  style: AppTextStyles.appsubTitle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
