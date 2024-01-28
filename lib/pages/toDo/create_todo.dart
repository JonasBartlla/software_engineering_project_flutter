//import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/navbar.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
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
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
      appBar: AppBar(
        title: Center(child: Text(
          'To-Do erstellen',
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
                     borderRadius : BorderRadius.only(
                     topLeft: Radius.circular(10),
                     topRight: Radius.circular(10),
                     bottomLeft: Radius.circular(10),
                     bottomRight: Radius.circular(10),
                      ),
                    color : Color.fromRGBO(63, 63, 63, 1),
                     ),
                     child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(
                            child: Icon(Icons.add, color: Colors.white, size: 40.0,),
                            ),
                            const SizedBox(width: 2),
                            PhysicalModel(
                              color: const Color.fromRGBO(63, 63, 63, 1),
                              elevation: 8,
                              shadowColor: const Color(0xFF212121),
                              child: SizedBox(  height: 45, width: 303,          
                                  //Bezeichnung eingeben
                                  child: TextFormField(
                                  style: const TextStyle(
                                   color: Colors.white
                                  ),
                                  initialValue: "",
                                  decoration: textInputDecorationbez.copyWith(hintText: 'Bezeichnung'),
                                  onChanged: (value) => setState(() {
                                  bezeichnung = value;
                                 }),
                                ),
                                ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        //dropdown Kategorie
                        Row(
                          children: <Widget>[
                            const SizedBox(
                            child: Icon(Icons.list_alt_rounded, color: Colors.white, size: 40.0,),
                            ),  
                            const SizedBox(width: 2),                          
                        SizedBox(width: 303,
                  child: PhysicalModel(
                    color: const Color.fromRGBO(63, 63, 63, 1),
                    elevation: 8,
                    shadowColor: const Color(0xFF212121),
                    child: DropdownButtonFormField<String>(
                      decoration: textInputDecoration.copyWith(hintText: 'Kategorie'),
                      value: 'Haushalt',
                      icon: const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white,),
                      dropdownColor: const Color.fromRGBO(63, 63, 63, 1),
                      items: categories.map((category){
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category,
                          style: const TextStyle(
                            color: Color.fromARGB(159, 214, 214, 214),
                          ),),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        kategorie = value!;
                      }),
                    ),
                  ),
                        ),
                      ]),
                  const SizedBox(height: 20,),
                  //dropdown Priorität
                  Row(
                          children: <Widget>[
                            const SizedBox(
                            child: Icon(Icons.arrow_upward, color: Colors.white, size: 40.0,),
                            ),
                            const SizedBox(width: 2),                            
                        SizedBox(width: 303,
                  child: PhysicalModel(
                    color: const Color.fromRGBO(63, 63, 63, 1),
                    elevation: 8,
                    shadowColor: const Color(0xFF212121),
                    child: DropdownButtonFormField<String>(                      
                      decoration: textInputDecoration.copyWith(hintText: 'Priorität'),
                      dropdownColor: const Color.fromRGBO(63, 63, 63, 1),
                      icon: const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white,),
                      elevation: 8,
                      value: 'Mittel',
                      items: priorities.map((priority){
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(priority,
                          style: const TextStyle(
                            color: Color.fromARGB(159, 214, 214, 214),
                          ),),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        _currentPriority = value!;
                      }),
                    ),
                  ),
                        ),
                      ]),
                  const SizedBox(height: 20,),
                  //Datum-Picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                     SizedBox(width: 340,
                      child: TextButton.icon(
                        style: buttonStyleDecoration,
                        onPressed: () => _selectDate(context), 
                        icon: const Icon(Icons.calendar_month_outlined, color: Colors.white,),
                        label: const Align(alignment: Alignment.centerLeft, child: Text(
                          'Fälligkeitsdatum',
                          style: TextStyle(
                            color: Color.fromARGB(159, 214, 214, 214)
                          ),
                        ),
                        ),
                        )),
                  ]),
                  const SizedBox(height: 20,),
                  //Uhrzeit-Picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 5),
                      SizedBox(width: 340,
                      child: TextButton.icon(
                        icon: const Icon(Icons.watch_later_outlined, color: Colors.white),
                        style: buttonStyleDecoration,
                        label:  const Align(alignment: Alignment.centerLeft, child: Text(
                          'Uhrzeit',
                          style: TextStyle(
                            color: Color.fromARGB(159, 214, 214, 214)
                          ),
                        ),),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  //Notiz
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 5),
                      PhysicalModel(
                        color: const Color.fromRGBO(63, 63, 63, 1),
                        elevation: 8,
                        shadowColor: const Color(0xFF212121),
                        child: SizedBox(width: 340, height: 230,
                                          child: TextFormField(
                                            maxLines: null,
                                            expands: true,
                                            textAlign: TextAlign.start,
                                            initialValue: "",
                                            decoration: textInputDecoration.copyWith(hintText: 'Notiz'),
                                            onChanged: (value) => setState(() {
                        notiz = value;
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
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: const Text('Abbrechen',
                         style: TextStyle(color: Colors.white,),),
                      ),
                      ),
                      const SizedBox(width: 30,),
                      SizedBox(
                  //Erstellen Button
                  child: ElevatedButton(
                    style: buttonStyleDecorationcolorchange,
                    child: const Text('Erstellen'),
                    onPressed: (){
                      addtasktofirebase();
                      Navigator.pop(context);
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