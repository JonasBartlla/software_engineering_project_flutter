import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/image_picker.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/services/upload_image.dart';

class MySettings extends StatefulWidget {
  final appUser currentUser;
  final DatabaseService databaseService;
  const MySettings(
      {required this.currentUser, required this.databaseService, super.key});

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  Uint8List? _image;
  late appUser currentUser;
  late DatabaseService _databaseService;
  late String changedDisplayName;
  final StoreData imageStorage = StoreData();
  final _formKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  // Future _getImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

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
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(currentUser.imageUrl),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: AppColors.myCheckItGreen,
                      ),
                    ),
                    bottom: -10,
                    left: 90,
                  )
                ],
              ),
              const SizedBox(height: 20),
              // Container(
              //   height: 100,
              //   width: 100,
              //   child: Image.network(currentUser.imageUrl)),
              // // Benutzername
                  PhysicalModel(
                    color: AppColors.myBackgroundColor,
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        cursorColor: AppColors.myCheckItGreen,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
                        style: const TextStyle(color: Colors.white),
                        initialValue: currentUser
                            .displayName, // Hier dann Benutzername aus DB
                        decoration: textInputDecorationbez.copyWith(
                            hintText: 'Anzeigename'),
                        onChanged: (value) => setState(() {
                          changedDisplayName = value;
                        }),
                        validator: (value) {
                          if (value!.length > 0) {
                            return null;
                          } else {
                            return "Der Benutzername darf nicht leer sein";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print(
                            "${currentUser.uid} ${changedDisplayName} ${currentUser.email}");
                        String imageUrl = currentUser.imageUrl;
                        if (_image != null) {
                          imageUrl = await imageStorage.uploadImageToStorage(
                              currentUser.email, _image!);
                        }
                        await _databaseService.updateUserDate(currentUser.uid,
                            changedDisplayName, currentUser.email, imageUrl);
                        print('updated');
                      } else {
                        print('unable to update');
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(25),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.myCheckItGreen,
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Text('Profil Speichern',
                        style: standardTextDecoration.copyWith(
                            fontWeight: FontWeight.bold)),
                  ),
              const SizedBox(height: 14),

              //ElevatedButton(onPressed: _getImage, child: Text('Bild hinzufügen')),
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
