import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/color_picker.dart';
import 'package:software_engineering_project_flutter/shared/icon_picker.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class EditListPage extends StatefulWidget {
  final List<String> existingLists;
  final TaskList taskList;
  const EditListPage(
      {required this.existingLists, required this.taskList, super.key});

  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  late TaskList taskList = widget.taskList;
  final _formKey = GlobalKey<FormState>();

  //Felder einer Liste zum aktivieren des Speichern-Buttons
  late String originalTitle = taskList.description;
  late IconData originalIcon = taskList.icon;
  late Color originalIconColor = taskList.iconColor;

  //Felder einer Liste
  late String title = taskList.description;
  late IconData icon = taskList.icon;
  late Color iconColor = taskList.iconColor;

  bool informationChanged(){
    return originalTitle != title || originalIcon != icon || originalIconColor != iconColor;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.myBackgroundColor, size: 35),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
        title: Text(
          'Liste bearbeiten',
          style: standardAppBarTextDecoration,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: Container(
                    width: 360,
                    height: 300,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: AppColors.myCheckITDarkGrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.circle_outlined,
                              color: Colors.white,
                              size: 32.0,
                            ),
                            const SizedBox(width: 12),
                            PhysicalModel(
                              color: AppColors.myCheckITDarkGrey,
                              shadowColor: AppColors.myShadowColor,
                              child: SizedBox(
                                width: 300,
                                //Bezeichnung eingeben
                                child: TextFormField(
                                  cursorColor: AppColors.myCheckItGreen,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(16)
                                  ],
                                  style: standardTextDecoration,
                                  initialValue: taskList.description,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Bitte eine Bezeichnung eingeben';
                                    } else if (value.length > 20) {
                                      return 'Bezeichnung darf nicht länger als 20 Zeichen sein';
                                    } else if(widget.existingLists.contains(value) && value != taskList.description){                                      
                                      return 'Es existiert bereits eine Liste mit diesem Name.\nBitte wählen Sie eine andere Bezeichnung';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: textInputDecorationbez.copyWith(
                                      hintText: 'Bezeichnung'),
                                  onChanged: (value) => setState(() {
                                    title = value;
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 45),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            const Text(
                              'Icon:',
                              style: TextStyle(
                                  color: AppColors.myTextColor,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Center(
                              child: IconButton(
                                style: buttonBoxDecoration.copyWith(
                                    fixedSize: MaterialStateProperty.all(
                                        Size(100, 40))),
                                color: AppColors.myBoxColor,
                                icon: Icon(
                                  icon,
                                  color: iconColor,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return IconPickerDialog(
                                            iconColor: iconColor,
                                            onIconSelected: (selectedIcon) {
                                              setState(() {
                                                icon = selectedIcon;
                                              });
                                            });
                                      });
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            const Text(
                              'Farbe:',
                              style: TextStyle(
                                  color: AppColors.myTextColor,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Center(
                              child: TextButton(
                                style: buttonBoxDecoration.copyWith(
                                    backgroundColor:
                                        MaterialStatePropertyAll(iconColor),
                                    fixedSize: MaterialStateProperty.all(
                                        Size(100, 40))),
                                child: const SizedBox(height: 10),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ColorPickerDialog(
                                            onColorSelected: (selectedColor) {
                                          setState(() {
                                            iconColor = selectedColor;
                                          });
                                        });
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: const Alignment(1, 0.6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  //Abbrechen Button
                                  child: TextButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            AppColors.myCheckITDarkGrey)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Abbrechen',
                                      style: TextStyle(
                                          color: AppColors.myTextColor,
                                          fontFamily: 'Comfortaa',
                                          fontSize: 14,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              //Speichern Button
                              child: ElevatedButton(
                                style: buttonStyleDecorationcolorchange.copyWith(
                                  backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return AppColors.myTextInputColor;
                          }
                          return AppColors.myCheckItGreen;
                        }),
                                ),
                                onPressed: informationChanged() ? () {
                                  if (_formKey.currentState!.validate()) {
                                    _database.editList(
                                        title,
                                        icon,
                                        iconColor,
                                        widget.taskList.listReference,
                                        widget.taskList.creationDate,
                                        widget.taskList.isEditable,
                                        widget.taskList.ownerId);
                                    Navigator.pop(context);
                                  }
                                } : null,
                                child: const Text(
                                  'Speichern',
                                  style: TextStyle(
                                      color: AppColors.myTextColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Vorschau:',
                  style: TextStyle(
                      color: AppColors.myTextInputColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 170,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      color: AppColors.myCheckITDarkGrey,
                      surfaceTintColor: AppColors.myCheckITDarkGrey,
                      margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8.0),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icon,
                                      color: iconColor,
                                      size: 48.0,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      title,
                                      style: standardHeadlineDecoration,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5.0),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              right: 8.0,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Center(
                                    child: Text(
                                  '1',
                                  style: standardTextDecoration.copyWith(
                                      color: Colors.black),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
