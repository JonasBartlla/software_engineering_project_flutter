import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class Datenschutz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myBackgroundColor,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.myBackgroundColor,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Icon(Icons.lightbulb,
              color: AppColors.myBackgroundColor, size: 30),
          backgroundColor: AppColors.myCheckItGreen),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Datenschutz
              Container(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Datenschutz',
                        style: standardTextDecoration.copyWith(
                            color: AppColors.myCheckItGreen, fontSize: 18)),
                    const SizedBox(height: 20),
                    Text(
                        'Deine Daten sind uns wichtig. Aber ehrlich gesagt, wir haben genug damit zu tun, unsere eigenen Termine einzuhalten, um uns um deine persönlichen Informationen zu kümmern. Wir versprechen jedoch, dass wir deine Daten nicht verkaufen werden, es sei denn, jemand bietet uns eine lebenslange Versorgung mit Paulaner Spezi an. In diesem Fall müssten wir nochmal darüber reden.',
                        style: standardTextDecoration,
                        textAlign: TextAlign.justify),
                  ],
                ),
              ),              
              // Watermark
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'CheckIT',
                        style: WaterMarkDecoration,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ver.1.1.0',
                        style: creditTextDecoration,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'CheckIT GmbH @ 2024',
                        style: creditTextDecoration,
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
