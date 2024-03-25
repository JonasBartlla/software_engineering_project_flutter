import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class CheckITPercentIndicator extends StatelessWidget {
  final double progressPercent;
  final Color progressColor;

  const CheckITPercentIndicator({required this.progressPercent, required this.progressColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(15.0),
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 20,
                  animationDuration: 500,
                  percent: progressPercent,
                 // center: Text("${(progressPercent * 100).toInt().toString()}%"),
                  trailing: Text("${(progressPercent * 100).toInt().toString()}%", style: standardTextDecoration,),
                  barRadius: const Radius.circular(15),
                  progressColor: progressColor,
                  backgroundColor: AppColors.myTextInputColor,
                ),
                );
  }
}