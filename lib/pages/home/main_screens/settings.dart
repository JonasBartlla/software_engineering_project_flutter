import 'dart:io';
import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class MySettings extends StatefulWidget {
  final appUser currentUser;
  final DatabaseService databaseService;
  const MySettings({required this.currentUser, required this.databaseService, super.key});


  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  File? _image;
  late appUser currentUser;
  late DatabaseService _databaseService;
  late String changedDisplayName;
  final _formKey = GlobalKey<FormState>();



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
  void initState() {
    currentUser = widget.currentUser;
    _databaseService = widget.databaseService;
    changedDisplayName = widget.currentUser.displayName;
  }



  
  
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
      body: Form(
        key: _formKey,
        child: Center(
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20)
                        ],
                        style: const TextStyle(color: Colors.white),
                        initialValue: currentUser.displayName, // Hier dann Benutzername aus DB
                        decoration: textInputDecorationbez.copyWith(
                            hintText: 'Anzeigename'),
                        onChanged: (value) => setState(() {
                          changedDisplayName = value;
                          }
                        ),
                        validator: (value) {
                          if (value!.length >0){
                            return null;
                          }else{
                            return "Der Benutzername darf nicht leer sein";
                          }
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: ()async{
                      if (_formKey.currentState!.validate()) {
                        print("${currentUser.uid} ${changedDisplayName} ${currentUser.email}");
                        await _databaseService.updateUserDate(currentUser.uid, changedDisplayName, currentUser.email);
                        print('updated');
                      }else{
                        print('unable to update');
                      }
                    }, 
                    child: Icon(
                      Icons.save,
                      size: 35,
                      color: AppColors.myCheckItGreen,
                    )
                  )
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
      ),
    );
  }
}
