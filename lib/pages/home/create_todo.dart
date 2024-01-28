import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_engineering_project_flutter/services/database.dart';
import 'package:software_engineering_project_flutter/shared/functions.dart';
import 'package:provider/provider.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {


  
  final _formKey = GlobalKey<FormState>();

  //Felder eines ToDos
  String bezeichnung = '';
  String notiz = '';
  String kategorie = 'Keine Kategorie';
  String prioritaet = '';
  DateTime? dateAndTime; //= DateTime.now();

  //Listen für die Dropdowns
  List<String> categories = ['Arbeit', 'Schule', 'Haushalt'];
  List<String> priorities = ['Hoch', 'Mittel', 'Niedrig'];
  List<DocumentReference> lists= [];
  
  
  @override
  Widget build(BuildContext context) {

      final User? user = Provider.of<User?>(context);
      final DatabaseService _database = DatabaseService(uid: user?.uid);

      return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
      appBar: AppBar(
        title: const Text(
          'To-Do erstellen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20,),
              //Bezeichnung eingeben
              TextFormField(
                style: const TextStyle(
                  color: Colors.white
                ),
                initialValue: "",
                validator: (value) {
                  if (value!.isEmpty){
                    return 'Bitte eine Bezeichnung eingeben';
                  }
                  else if (value!.length > 35){
                    return 'Bezeichnung darf nicht länger als 35 Zeichen sein';
                  }
                },
                decoration: textInputDecoration.copyWith(hintText: 'Bezeichnung'),
                onChanged: (value) => setState(() {
                  bezeichnung = value;
                }),
              ),
              const SizedBox(height: 20),
              //dropdown Kategorie
              DropdownButtonFormField<String>(
                decoration: textInputDecoration.copyWith(hintText: 'Kategorie'),
                //value: 'Haushalt',
                icon: const Icon(Icons.arrow_drop_down_rounded, size: 30,),
                dropdownColor: const Color.fromRGBO(63, 63, 63, 1),
                items: categories.map((category){
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category,
                    style: const TextStyle(
                      color: Colors.white,
                    ),),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  kategorie = value!;
                }),
              ),
              const SizedBox(height: 20,),
              //dropdown Priorität
              DropdownButtonFormField<String>(
                decoration: textInputDecoration.copyWith(hintText: 'Priorität'),
                dropdownColor: const Color.fromRGBO(63, 63, 63, 1),
                icon: const Icon(Icons.arrow_drop_down_rounded, size: 30,),
                //value: 'Mittel',
                items: priorities.map((priority){
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority,
                    style: const TextStyle(
                      color: Colors.white,
                    ),),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  prioritaet = value!;
                }),
              ),
              const SizedBox(height: 20,),
              //Notiz
              TextFormField(
                initialValue: "",
                validator: (value) => value!.length > 300 ? 'Notiz darf nicht länger als 300 Zeichen sein' : null,
                decoration: textInputDecoration.copyWith(hintText: 'Notiz'),
                onChanged: (value) => setState(() {
                  notiz = value;
                }),
              ),
              const SizedBox(height: 20),
              //Datum-Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Datum: '),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    style: buttonStyleDecoration,
                    onPressed: () async {
                      DateTime? pickedDate = await showDateTimePicker(context: context);
                      //if (pickedDate != null){
                        setState(() {
                          dateAndTime = pickedDate;
                        });
                      //}
                    },
                    child: dateAndTime == null ? 
                      const Text('Datum eingeben') : 
                      Text('${DateFormat('dd.MM.yyyy').format(dateAndTime!)} ${dateAndTime!.hour.toString().padLeft(2, '0')}:${dateAndTime!.minute.toString().padLeft(2, '0')}'),
                  ),
              ]),
              const SizedBox(height: 20,),
              //Uhrzeit-Picker [maybe irrelevant]
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text('Uhrzeit: '),
              //     const SizedBox(width: 10,),
              //     ElevatedButton(
              //       style: buttonStyleDecoration,
              //       child: Text('${dateAndTime!.hour.toString().padLeft(2, '0')}:${dateAndTime!.minute.toString().padLeft(2, '0')}'),
              //       onPressed: () async { //man kann das hier auch als Funktion in einer seperaten Datei machen
              //         final TimeOfDay? timeOfDay = await showTimePicker(
              //           context: context,
              //           initialTime: TimeOfDay.fromDateTime(dateAndTime!),
              //           builder: (BuildContext context, Widget? child){
              //             return MediaQuery(data: MediaQuery.of(context).copyWith(
              //               alwaysUse24HourFormat: true), 
              //               child: child!
              //               );
              //           }
              //         );
              //         if(timeOfDay != null){
              //           setState(() {
              //             //dateAndTime = DateTime(dateAndTime!.year, dateAndTime!.month, dateAndTime!.day, timeOfDay.hour, timeOfDay.minute);
              //           });
              //         }
              //       },
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Abbrechen Button
                  TextButton.icon(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    label: const Text('Abbrechen', style: TextStyle(color: Color.fromARGB(159, 214, 214, 214),),),
                    icon: const Icon(Icons.close,color: Color.fromARGB(159, 214, 214, 214),),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
                    ),
                  ),
                  const SizedBox(width: 30,),
                  //Erstellen Button
                  ElevatedButton(
                    style: buttonStyleDecoration,
                    child: const Text('Erstellen'),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _database.addTask(bezeichnung, notiz, dateAndTime, prioritaet, lists);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  const SizedBox(height: 20,),
                  Text(dateAndTime.toString(), style: TextStyle(color: Colors.white),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}