import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/date_time_picker_widget.dart';
import 'package:provider/provider.dart';

class EditTodo extends StatefulWidget {
  
  final Task task; 
  const EditTodo({required this.task, super.key});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {

  late Task task = widget.task;
  final _formKey = GlobalKey<FormState>();

  //Felder eines ToDos
  late String title = task.description;
  late String note = task.note;
  late String list = 'default';
  late String priority = task.priority;
  late DateTime maturityDate = task.maturityDate; //soll nicht null sein

  //Listen für die Dropdowns
  List<String> categories = ['Arbeit', 'Schule', 'Haushalt'];
  List<String> priorities = ['Hoch', 'Mittel', 'Niedrig'];
  List<DocumentReference> lists = [];



  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
      appBar: AppBar(
        title: Center(
            child: Text(
          'To-Do bearbeiten',
          style: standardAppBarTextDecoration,
        )),
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
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
                        color: Color.fromRGBO(63, 63, 63, 1),
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
                              const SizedBox(width: 2),
                              PhysicalModel(
                                color: const Color.fromRGBO(63, 63, 63, 1),
                                //elevation: 8,
                                shadowColor: const Color(0xFF212121),
                                child: SizedBox(
                                  width: 303,
                                  //Bezeichnung eingeben
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    initialValue: title,
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
                          const SizedBox(height: 20),
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
                                color: const Color.fromRGBO(63, 63, 63, 1),
                                elevation: 8,
                                shadowColor: const Color(0xFF212121),
                                child: DropdownButtonFormField<String>(
                                  value: task.list,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Liste'),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  dropdownColor:
                                      const Color.fromRGBO(63, 63, 63, 1),
                                  items: categories.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              159, 214, 214, 214),
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
                            height: 20,
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
                                color: const Color.fromRGBO(63, 63, 63, 1),
                                elevation: 8,
                                shadowColor: const Color(0xFF212121),
                                child: DropdownButtonFormField<String>(
                                  value: task.priority == 'no priority' ? null : task.priority,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Priorität'),
                                  dropdownColor:
                                      const Color.fromRGBO(63, 63, 63, 1),
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
                                          color: Color.fromARGB(
                                              159, 214, 214, 214),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() {
                                    priority = value!;
                                  }),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
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
                                    child: TextButton(
                                      style: buttonStyleDecoration,
                                      onPressed: () async {
                                        DateTime pickedDate =
                                            await showDateTimePicker(
                                                context: context) ?? DateTime.fromMicrosecondsSinceEpoch(0);
                                        setState(() {
                                          maturityDate = pickedDate;
                                        });
                                      },
                                      child: maturityDate == DateTime.fromMillisecondsSinceEpoch(0)
                                          ? const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Fälligkeit',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        159, 214, 214, 214)),
                                              ),
                                            )
                                          : Text(
                                              '${DateFormat('dd.MM.yyyy').format(maturityDate)} ${maturityDate.hour.toString().padLeft(2, '0')}:${maturityDate.minute.toString().padLeft(2, '0')}'),
                                    )),
                              ]),
                          const SizedBox(
                            height: 20,
                          ),
                          //Notiz
                          Row(children: <Widget>[
                            const SizedBox(width: 5),
                            PhysicalModel(
                              color: const Color.fromRGBO(63, 63, 63, 1),
                              elevation: 8,
                              shadowColor: const Color(0xFF212121),
                              child: SizedBox(
                                width: 340,
                                height: 300,
                                child: TextFormField(
                                  maxLines: null,
                                  expands: true,
                                  textAlign: TextAlign.start,
                                  validator: (value) => value!.length > 300
                                      ? 'Notiz darf nicht länger als 300 Zeichen sein'
                                      : null,
                                  initialValue: note,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Notiz'),
                                  onChanged: (value) => setState(() {
                                    note = value;
                                  }),
                                ),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 20),
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
                                  child: const Text('Speichern'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _database.editTask(title, note, maturityDate, false, priority, list, false, task.taskReference);
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
