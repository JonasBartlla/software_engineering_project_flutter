import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class EditListPage extends StatefulWidget {

  final List<String> existingLists;
  final TaskList taskList;
  const EditListPage({required this.existingLists, required this.taskList, super.key});

  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  
  late TaskList taskList = widget.taskList;
  final _formKey = GlobalKey<FormState>();

  //Felder einer Liste
  late String title = taskList.description;
  late IconData icon = taskList.icon;

  //Liste für die auswählbaren Icons
  List<IconData> choosableIcons = [
    Icons.abc,
    Icons.house,
    Icons.calendar_month_rounded
  ];
  
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
        title: Center(
          child: Text(
            'Liste erstellen',
            style: standardAppBarTextDecoration,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 460,
                    height: 280,
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
                            const SizedBox(
                              child: Icon(
                                Icons.circle_outlined,
                                color: Colors.white,
                                size: 40.0,
                              ),
                            ),
                            const SizedBox(width: 5),
                            PhysicalModel(
                              color: AppColors.myCheckITDarkGrey,
                              //elevation: 8,
                              shadowColor: AppColors.myShadowColor,
                              child: SizedBox(
                                width: 303,
                                //Bezeichnung eingeben
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20)
                                  ],
                                  style: const TextStyle(
                                      color: AppColors.myTextColor),
                                  initialValue: "",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Bitte eine Bezeichnung eingeben';
                                    } else if (value.length > 20) {
                                      return 'Bezeichnung darf nicht länger als 20 Zeichen sein';
                                    } else if(widget.existingLists.contains(value)){
                                      return 'Es existiert bereits eine Liste mit diesem Name.\nBitte wählen Sie eine andere Bezeichnung';
                                    }else {
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
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 288,
                              child: DropdownButtonFormField<IconData>(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Icon'),
                                  items: choosableIcons.map((icon) {
                                    return DropdownMenuItem(
                                      value: icon,
                                      child: Icon(icon),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() {
                                        icon = value!;
                                      })),
                            ),
                          ],
                        ),
                        const SizedBox(height: 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                //Löschen Button
                                child: TextButton(
                                  style: buttonStyleDecorationDelete,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Löschen',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                            SizedBox(
                              //Abbrechen Button
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Abbrechen',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              //Bearbeiten Button
                              child: ElevatedButton(
                                style: buttonStyleDecorationcolorchange,
                                child: const Text('Bearbeiten'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _database.editList(title, icon, widget.taskList.listReference, widget.taskList.creationDate, widget.taskList.isEditable, widget.taskList.ownerId);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  width: 350,
                  child: Card(
                    color: AppColors.myCheckITDarkGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon, color: AppColors.myCheckItGreen,),
                            const SizedBox(height: 20),
                            Text(title, style: standardHeadlineDecoration,)
                          ],
                        ),
                      ),                  
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}