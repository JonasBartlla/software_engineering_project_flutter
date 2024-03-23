import 'dart:io';
import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class MySettings extends StatefulWidget {
  // const MySettings({super.key});

  const MySettings({Key? key})
      : super(key: key);

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  File? _image;



  Future _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    String? displayName = user!.displayName;
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
                      initialValue: displayName, // Hier dann Benutzername aus DB
                      decoration: textInputDecorationbez.copyWith(
                          hintText: 'Dennis der Boss'),
                      onChanged: (value) => setState(() {
                        displayName = value;
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
            const SizedBox(height: 14),

            ElevatedButton(onPressed: _getImage, child: Text('Bild hinzufügen')),
            Center(
              // child: _image == null ? Text('kein Bild ausgewählt'): Image.asset(_image),
            ),

            // Unten am Bildschirm
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
    );
  }
}
