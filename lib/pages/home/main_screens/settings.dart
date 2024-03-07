import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
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
        title: Text(
          'Einstellungen',
          style: standardAppBarTextDecoration,
        ),
        backgroundColor: AppColors.myCheckItGreen,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            //Bild
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.myTextColor,
              ),
              child: const Icon(
                Icons.person,
                size: 150,
                color: AppColors.myAbbrechenColor,
              ),
            ),
            const SizedBox(height: 20),
            // Benutzername
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhysicalModel(
                  color: AppColors.myBackgroundColor,
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      initialValue: null, // Hier dann Benutzername aus DB
                      decoration: textInputDecorationbez.copyWith(
                          hintText: 'Dennis der Boss'),
                      onChanged: (value) => setState(() {
                        value = value;
                      }),
                    ),
                  ),
                ),
                const Icon(
                  Icons.save,
                  size: 35,
                  color: AppColors.myCheckItGreen,
                ),
              ],
            ),

            // Unten am Bildschirm
            const SizedBox(height: 140),
            Text(
              'CheckIT',
              style: WaterMarkDecoration,
            ),
            const SizedBox(height: 40),

            Text(
              'ver.1.1.0',
              style: creditTextDecoration,
            ),
            const SizedBox(height: 10),
            Text(
              'CheckIT GmbH @ 2024',
              style: creditTextDecoration,
            ),
          ],
        ),
      ),
    );
  }
}
