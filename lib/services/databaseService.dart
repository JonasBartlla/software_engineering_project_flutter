import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:software_engineering_project_flutter/models/appUser.dart';
import 'package:software_engineering_project_flutter/models/taskList.dart';

class DatabaseService{
  //collection reference

  final String? uid;
  late final CollectionReference userCollection;
  late final CollectionReference listCollection;
  late final CollectionReference taskCollection;
  late final CollectionReference referenceCollection;
  DatabaseService({this.uid}){
    userCollection = FirebaseFirestore.instance.collection('users');
    listCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('lists');
    taskCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks');
    referenceCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('references');
  }

  //final CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks');



  Future updateUserDate(String displayName, String? email) async {
    return await userCollection.doc(uid).set(
      {
        'displayName': displayName,
        'email': email,
      }
    );
  }

  // task list from Snapshot
  List<appUser> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return appUser(
        name: doc.get('name') ?? '' , // if value is null return empty string
        hobby: doc.get('hobby') ?? '', 
        age: doc.get('age') ?? 0);
    }).toList();
  }

  
    //add List
  Future addList(String bezeichnung, IconData icon) async {
    return await listCollection.add({
      'bezeichnung': bezeichnung,
      'icon': icon.codePoint,
      'taskCounter': 0,
    });
     //IconData(iconCodePointFromDataBase, fontFamily: 'MaterialIcons')
  }
  //editing List
  Future editList(String bezeichnung, IconData icon, DocumentReference list) async {
    return await list.set({
      'bezeichnung': bezeichnung,
      'icon': icon.codePoint
    });
  }
  //deleting List
  Future deleteList(DocumentReference list) async {
    return await list.delete();
    //return await updateTaskListReferences(task: null,lists: list as List<DocumentReference>);
  }

  //add Task
  Future addTask(String bezeichnung, String notiz, DateTime selectedDate, TimeOfDay uhrzeit, String priority, List<DocumentReference>? lists) async {
    //adding the Task
    return await taskCollection.add({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'wiedervorlagedatum': Timestamp.fromDate(DateTime.now()),
      'uhrzeit': uhrzeit.toString(),
      'priorität': priority
    }); 
    //adding references
    //return await updateTaskListReferences(task: task,lists: lists);
  }
  //editingTask
  Future editTask(String bezeichnung, String notiz, DateTime selectedDate, TimeOfDay uhrzeit, String priority, DocumentReference taskId, List<DocumentReference>? lists) async {
    return await taskId.set({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'wiedervorlagedatum': Timestamp.fromDate(DateTime.now()),
      'uhrzeit': uhrzeit.toString(),
      'priorität': priority
    }); 
    //return await updateTaskListReferences(task: taskId, lists: lists);
  }

  Future deleteTask(DocumentReference task) async{
    return await task.delete();
    //return await updateTaskListReferences(task: task, lists: null);
  }
  // get user Stream
  Stream<List<appUser>> get users {
    return userCollection.snapshots().map(_taskListFromSnapshot);
  }


}