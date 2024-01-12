//import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/buttonstyle.dart';
import 'package:software_engineering_project_flutter/shared/textinputdecoration.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({super.key});

  @override
  State<CreateToDo> createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {

  final _formKey = GlobalKey<FormState>();

  String bezeichnung = '';
  String notiz = '';
  String kategorie = '';
  List<String> categories = ['Arbeit', 'Schule', 'Haushalt'];
  DateTime selectedDate = DateTime.now();
  TimeOfDay uhrzeit = TimeOfDay.now();
  List<String> priorities = ['Hoch', 'Mittel', 'Niedrig'];
  
  String _currentPriority = '';


   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  //Funktion, um eine Task hinzuzufügen
  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;
    //var time = DateTime.now();
    await FirebaseFirestore.instance.collection('tasks')
    .doc(uid)
    //.collection('mytasks')
    //.doc(time.toString())
    .set({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'kategorie': kategorie,
      'datum': selectedDate.toString(),
      'uhrzeit': uhrzeit.toString(),
      'priorität': _currentPriority 
      });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.grey[850],
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
              SizedBox(height: 20,),
              //Bezeichnung eingeben
              TextFormField(
                initialValue: "",
                decoration: textInputDecoration.copyWith(hintText: 'Bezeichnung'),
                onChanged: (value) => setState(() {
                  bezeichnung = value;
                }),
              ),
              const SizedBox(height: 20),
              //dropdown Kategorie
              DropdownButtonFormField<String>(
                decoration: textInputDecoration.copyWith(hintText: 'Kategorie'),
                value: 'Haushalt',
                items: categories.map((category){
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
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
                value: 'Mittel',
                items: priorities.map((priority){
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _currentPriority = value!;
                }),
              ),
              const SizedBox(height: 20,),
              //Notiz
              TextFormField(
                initialValue: "",
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
                    onPressed: () => _selectDate(context), 
                    child: Text(DateFormat('dd.MM.yyyy').format(selectedDate)),
                  ),
              ]),
              const SizedBox(height: 20,),
              //Uhrzeit-Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Uhrzeit: '),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    style: buttonStyleDecoration,
                    child: Text('${uhrzeit.hour}:${uhrzeit.minute}'),
                    onPressed: () async { //man kann das hier auch als Funktion in einer seperaten Datei machen
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: uhrzeit,
                        builder: (BuildContext context, Widget? child){
                          return MediaQuery(data: MediaQuery.of(context).copyWith(
                            alwaysUse24HourFormat: true), 
                            child: child!
                            );
                        }
                      );
                      if(timeOfDay != null){
                        setState(() {
                          uhrzeit = timeOfDay;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              //Erstellen Button
              ElevatedButton(
                style: buttonStyleDecoration,
                child: const Text('Erstellen'),
                onPressed: (){
                  addtasktofirebase();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}