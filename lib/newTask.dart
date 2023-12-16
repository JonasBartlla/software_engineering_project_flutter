
import 'dart:developer';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'task.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';

class NewTask extends StatelessWidget {

  final Task task;
  final VoidCallback delete;
  
  // ignore: use_key_in_widget_constructors
  NewTask(this.task, this.delete){
    
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
          ),
         SizedBox(height: 8.0,),
         TextButton.icon(
          onPressed: delete, 
          icon: Icon(Icons.delete), 
          label: Text('delete Task'),
          ) 
        ]
      ),
    );
  }
}

