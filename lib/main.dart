import 'dart:developer';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/Task.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';





void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MaterialApp(
  home: Home(),

  ));
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Task> tasks = [
    Task('Washing', Color.fromARGB(255, 255, 0, 0), 50.0),
    Task('Going for a Walk', Color.fromARGB(255, 0, 255, 0), 60.0),
    Task('Sheesh', Color.fromARGB(255, 204, 255, 18), 70.0)
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('CheckIT',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
        body: Column(
          children: tasks.map((task) {
              return NewTask(task);
              // return Container(
              //   height: task.height,
              //   decoration: BoxDecoration(
              //     color: task.color,
              //     border: Border(
              //       bottom: BorderSide(
              //         style: BorderStyle.solid
              //       )
              //     ),
              //   ),
              //   child: Center(
              //     child: Text(task.name,) ),
              // );
            }).toList(),
        ),
    );
  }
}

class NewTask extends StatelessWidget {

  final Task task;
  // ignore: use_key_in_widget_constructors
  NewTask(this.task){
    
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Column(
        children: <Widget>[
          Text(task.name,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,

            ),
          ),
          SizedBox(height: 6.0,),
          Text(task.name,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.blue
            ),
          )
        ]
      ),
    );
  }
}


