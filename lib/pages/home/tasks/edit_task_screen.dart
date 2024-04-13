import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/confirm_delete_pop_up.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/date_time_picker_widget.dart';
import 'package:provider/provider.dart';

class EditTodo extends StatefulWidget {
  final Task task;
  final List<String> availableLists;
  const EditTodo({required this.task, required this.availableLists, super.key});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  late Task task = widget.task;
  final _formKey = GlobalKey<FormState>();

  //Felder für den Speichernbutton Check
  late String originalTitle = task.description;
  late String originalNote = task.note;
  late DateTime originalCreationDate = task.creationDate;
  late String originalList = task.list;
  late int originalPriority = task.priority;
  late DateTime originalMaturityDate = task.maturityDate;

  //Felder eines ToDos
  late String title = task.description;
  late String note = task.note;
  late DateTime creationDate = task.creationDate;
  late String list = task.list;
  late int priority = task.priority;
  late DateTime maturityDate = task.maturityDate;
  late String ownerId = task.ownerId;

  //Listen für die Dropdowns
  late List<String> categories;
  List<String> priorities = ['keine Priorität', 'Hoch', 'Mittel', 'Niedrig'];
  List<DocumentReference> lists = [];

  bool informationChanged() {
    return originalTitle != title ||
        originalNote != note ||
        originalList != list ||
        originalPriority != priority ||
        originalMaturityDate != maturityDate;
  }

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
          'ToDo',
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
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 370,
                      height: 620,
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
                        children: <Widget>[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //const SizedBox(width: 6),
                              const SizedBox(
                                child: Icon(
                                  Icons.circle_outlined,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                              const SizedBox(width: 5),
                              PhysicalModel(
                                color: AppColors.myCheckITDarkGrey,
                                //elevation: 8,
                                shadowColor: AppColors.myShadowColor,
                                child: SizedBox(
                                  width: 309,
                                  //Bezeichnung eingeben
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(25)
                                    ],
                                    cursorColor: AppColors.myCheckItGreen,
                                    style: const TextStyle(
                                        color: AppColors.myTextColor,
                                        fontFamily: 'Comfortaa',
                                        fontSize: 16,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                    initialValue: title,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Bitte eine Bezeichnung eingeben';
                                      } else if (value.length > 35) {
                                        return 'Bezeichnung darf nicht länger als 35 Zeichen sein';
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
                          const SizedBox(height: 40),
                          //dropdown Kategorie
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  child: Icon(
                                    Icons.list,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 311,
                                  height: 55,
                                  child: PhysicalModel(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular((8)),
                                    color: AppColors.myCheckITDarkGrey,
                                    elevation: 8,
                                    shadowColor: AppColors.myShadowColor,
                                    child: DropdownButtonFormField<String>(
                                      value: task.list,
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Liste'),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      dropdownColor: AppColors.myBoxColor,
                                      items: categories.map((category) {
                                        return DropdownMenuItem(
                                          value: category,
                                          child: Text(category,
                                              style: standardTextDecoration),
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
                            height: 40,
                          ),
                          //dropdown Priorität
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //const SizedBox(width: 6),
                                const SizedBox(
                                  child: Icon(
                                    Icons.arrow_upward_rounded,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: 311,
                                  height: 55,
                                  child: PhysicalModel(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular((8)),
                                    color: AppColors.myCheckITDarkGrey,
                                    elevation: 8,
                                    shadowColor: AppColors.myShadowColor,
                                    child: DropdownButtonFormField<String>(
                                      value:
                                          _database.getPriority(task.priority),
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
                                          child: Text(priority,
                                              style: standardTextDecoration),
                                        );
                                      }).toList(),
                                      onChanged: (value) => setState(() {
                                        priority =
                                            _database.priorityDict[value]!;
                                      }),
                                    ),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 40,
                          ),
                          //Datum-Picker
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  child: Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                    width: 311,
                                    height: 55,
                                    child: TextButton(
                                      style: buttonStyleDecoration,
                                      onPressed: () async {
                                        DateTime pickedDate =
                                            await showDateTimePicker(
                                                    context: context) ??
                                                DateTime
                                                    .fromMicrosecondsSinceEpoch(
                                                        0);
                                        setState(() {
                                          maturityDate = pickedDate;
                                        });
                                      },
                                      child: maturityDate ==
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(0)
                                          ? const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Fälligkeit',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: AppColors
                                                        .myTextInputColor,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 16,
                                                    letterSpacing: 1,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height: 1),
                                              ))
                                          : Text(
                                              '${DateFormat('dd.MM.yyyy').format(maturityDate)} ${maturityDate.hour.toString().padLeft(2, '0')}:${maturityDate.minute.toString().padLeft(2, '0')}',
                                              style: standardTextDecoration,
                                            ),
                                    )),
                              ]),
                          const SizedBox(
                            height: 40,
                          ),
                          //Notiz
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                PhysicalModel(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular((8)),
                                  color: AppColors.myCheckITDarkGrey,
                                  elevation: 8,
                                  shadowColor: AppColors.myShadowColor,
                                  child: SizedBox(
                                    width: 345,
                                    height: 200,
                                    child: Align(
                                      child: TextFormField(
                                        cursorColor: AppColors.myCheckItGreen,
                                        style: const TextStyle(
                                            color: AppColors.myTextColor,
                                            fontFamily: 'Comfortaa',
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                        maxLines: null,
                                        expands: true,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        textAlign: TextAlign.start,
                                        validator: (value) => value!.length >
                                                300
                                            ? 'Notiz darf nicht länger als 300 Zeichen sein'
                                            : null,
                                        initialValue: note,
                                        decoration:
                                            textInputDecoration.copyWith(
                                          hintText: 'Notiz',
                                          alignLabelWithHint: true,
                                        ),
                                        onChanged: (value) => setState(() {
                                          note = value;
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Löschen Button
                      TextButton(
                        style: buttonStyleDecorationDelete,
                        onPressed: () async {
                          await showDeleteTaskConfirmationDialog(
                              task, _database, context);
                          // Navigator.pop(context);
                        },
                        child: const Icon (Icons.delete_rounded, color: Colors.white, size: 30,)
                      ),
                      const SizedBox(width: 20,),
                      //Abbrechen Button
                      TextButton(
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
                      const SizedBox(width: 20,),
                      //Speichern Button
                      ElevatedButton(
                        style: buttonStyleDecorationcolorchange.copyWith(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return AppColors.myTextInputColor;
                          }
                          return AppColors.myCheckItGreen;
                        })),
                        onPressed: informationChanged()
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  _database.editTask(
                                      title,
                                      note,
                                      creationDate,
                                      maturityDate,
                                      priority,
                                      list,
                                      false,
                                      ownerId,
                                      task.taskReference);
                                  Navigator.pop(context);
                                }
                              }
                            : null,
                        child: const Text('Speichern',
                            style: TextStyle(
                                color: AppColors.myTextColor,
                                fontFamily: 'Comfortaa',
                                fontSize: 14,
                                letterSpacing: 1,
                                fontWeight: FontWeight.normal,
                                height: 1)),
                      ),
                    ],
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
