import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class CheckITPercentIndicator extends StatelessWidget {
  final double progressPercent;
  const CheckITPercentIndicator({required this.progressPercent, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15.0),
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 20,
                  animationDuration: 2500,
                  percent: progressPercent,
                  center: Text("${(progressPercent * 100).toInt().toString()}%"),
                  barRadius: Radius.circular(15),
                  progressColor: AppColors.myCheckItGreen,
                ),
                );
  }
}