import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/date_time_picker_widget.dart';
import 'package:provider/provider.dart';

class CreateToDo extends StatefulWidget {
  final List<String> availableLists;
  const CreateToDo({required this.availableLists, super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  final _formKey = GlobalKey<FormState>();

  //Felder eines ToDos
  String title = '';
  String note = '';
  String list = 'default';
  int priority = 0;
  DateTime dateAndTime = DateTime.fromMillisecondsSinceEpoch(0); //soll nicht null sein

  //Listen für die Dropdowns
  late List<String> categories;
  List<String> priorities = ['Hoch', 'Mittel', 'Niedrig'];
  List<DocumentReference> lists = [];

  @override
  void initState() {
  categories = widget.availableLists;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

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
          'ToDo erstellen',
          style: standardAppBarTextDecoration,
        ),
        backgroundColor: AppColors.myCheckItGreen,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 360,
                      height: 650,
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
                                  Icons.add,
                                  color: Colors.white,
                                  size: 40.0,
                                ),
                              ),
                              const SizedBox(width: 2),
                              PhysicalModel(
                                color: AppColors.myCheckITDarkGrey,
                                //elevation: 8,
                                shadowColor: AppColors.myShadowColor,
                                child: SizedBox(
                                  width: 303,
                                  //Bezeichnung eingeben
                                  child: TextFormField(
                                    style: const TextStyle(color: AppColors.myTextColor),
                                    initialValue: "",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Bitte eine Bezeichnung eingeben';
                                      } else if (value.length > 35) {
                                        return 'Bezeichnung darf nicht länger als 35 Zeichen sein';
                                      } else{
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
                          const SizedBox(height: 50),
                          //dropdown Kategorie
                          Row(children: <Widget>[
                            const SizedBox(width: 6),
                            const SizedBox(
                              child: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 303,
                              child: PhysicalModel(
                                color: AppColors.myCheckITDarkGrey,
                                elevation: 8,
                                shadowColor: AppColors.myShadowColor,
                                child: DropdownButtonFormField<String>(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Liste'),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  dropdownColor:
                                      AppColors.myCheckITDarkGrey,
                                  items: categories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          color: AppColors.myTextInputColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() {
                                    list = value!;
                                  }),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 50,
                          ),
                          //dropdown Priorität
                          Row(children: <Widget>[
                            const SizedBox(width: 6),
                            const SizedBox(
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 303,
                              child: PhysicalModel(
                                color: AppColors.myCheckITDarkGrey,
                                elevation: 8,
                                shadowColor: AppColors.myShadowColor,
                                child: DropdownButtonFormField<String>(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Priorität'),
                                  dropdownColor:
                                      AppColors.myCheckITDarkGrey,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  elevation: 8,
                                  items: priorities.map((priority) {
                                    return DropdownMenuItem(
                                      value: priority,
                                      child: Text(
                                        priority,
                                        style: const TextStyle(
                                          color: AppColors.myTextInputColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() {
                                    priority = _database.priorityDict[value]!;
                                  }),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 50,
                          ),
                          //Datum-Picker
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 6),
                                const SizedBox(
                                  child: Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                    width: 303,
                                    height: 50,
                                    child: TextButton(
                                      style: buttonStyleDecoration,
                                      onPressed: () async {
                                        DateTime pickedDate =
                                            await showDateTimePicker(
                                                context: context) ?? DateTime.fromMicrosecondsSinceEpoch(0);
                                        setState(() {
                                          dateAndTime = pickedDate;
                                        });
                                      },
                                      child: dateAndTime == DateTime.fromMillisecondsSinceEpoch(0)
                                          ? const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Fälligkeit',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: AppColors.myTextInputColor),
                                              ),
                                            )
                                          : Text(
                                              '${DateFormat('dd.MM.yyyy').format(dateAndTime)} ${dateAndTime!.hour.toString().padLeft(2, '0')}:${dateAndTime.minute.toString().padLeft(2, '0')}',
                                              style: const TextStyle(color: AppColors.myTextColor),
                                              ),
                                    )),
                              ]),
                          const SizedBox(
                            height: 60,
                          ),
                          //Notiz
                          Row(children: <Widget>[
                            const SizedBox(width: 5),
                            PhysicalModel(
                              color: AppColors.myCheckITDarkGrey,
                              elevation: 8,
                              shadowColor: AppColors.myShadowColor,
                              child: SizedBox(
                                width: 340,
                                height: 100,
                                child: TextFormField(
                                  style: const TextStyle(color: AppColors.myTextColor),
                                  maxLines: null,
                                  expands: true,
                                  textAlign: TextAlign.start,
                                  validator: (value) => value!.length > 300
                                      ? 'Notiz darf nicht länger als 300 Zeichen sein'
                                      : null,
                                  initialValue: "",
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Notiz'),
                                  onChanged: (value) => setState(() {
                                    note = value;
                                  }),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                                width: 30,
                              ),
                              SizedBox(
                                //Erstellen Button
                                child: ElevatedButton(
                                  style: buttonStyleDecorationcolorchange,
                                  child: const Text('Erstellen'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _database.addTask(title, note,
                                          dateAndTime, false, priority, lists, false, list);
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
