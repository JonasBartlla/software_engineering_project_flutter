import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/textinputdecoration.dart';

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
  DateTime selectedDate = DateTime.now();
  TimeOfDay? uhrzeit;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const Text('To-Do erstellen'),
          const SizedBox(height: 20,),
          //Bezeichnung eingeben
          TextFormField(
            initialValue: "",
            decoration: textInputDecoration.copyWith(hintText: 'Bezeichnung'),
            onChanged: (value) => setState(() {
              bezeichnung = value;
            }),
          ),
          const SizedBox(height: 20),
          //dropdown Priorität
          DropdownButtonFormField<String>(
            decoration: textInputDecoration.copyWith(hintText: 'Priorität'),
            value: '',
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
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () => _selectDate(context), 
            child: const Text('Datum wählen'),
            ),


        ],
      ),
    );
  }
}