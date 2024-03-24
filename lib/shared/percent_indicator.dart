import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class CheckITPercentIndicator extends StatelessWidget {
  const CheckITPercentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15.0),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20,
                  animationDuration: 2500,
                  percent: 0.8,
                  center: Text("80.0%"),
                  barRadius: Radius.circular(15),
                  progressColor: AppColors.myCheckItGreen,
                ),
                );
  }
}