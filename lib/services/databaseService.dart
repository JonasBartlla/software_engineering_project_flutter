import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:software_engineering_project_flutter/models/appUser.dart';
import "package:software_engineering_project_flutter/models/taskList.dart";
import 'package:software_engineering_project_flutter/models/task.dart';

class DatabaseService{
  //collection reference
  
  final String? uid;
  late final CollectionReference userCollection;
  late final CollectionReference listCollection;
  late final CollectionReference taskCollection;
  DatabaseService({this.uid}){
    userCollection = FirebaseFirestore.instance.collection('users');
    listCollection = FirebaseFirestore.instance.collection('lists');
    taskCollection = FirebaseFirestore.instance.collection('tasks');
  }

  //final CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('taskCollection');



  Future updateUserDate(String displayName, String? email) async {
    return await userCollection.doc(uid).set(
      {
        'displayName': displayName,
        'email': email,
      }
    );
  }


  // Future testListReferences() async {
  //   return await addList(bezeichnung, icon)
  // }



  //add List
  Future addList(String bezeichnung, IconData icon) async {
    return await listCollection.add({
      'bezeichnung': bezeichnung,
      'icon': icon.codePoint,
      'taskCounter': 0,
      'ownerId': uid,
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
  }

  //add Task

  Future addTask(String bezeichnung, String notiz, DateTime selectedDate, String priority, List<DocumentReference>? lists) async {
    //adding the Task
    return  await taskCollection.add({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'datum': selectedDate.millisecondsSinceEpoch,
      'wiedervorlagedatum': Timestamp.fromDate(DateTime.now()),
      'priorität': priority,
      'owner_id': uid
    }); 
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
  }

  Future deleteTask(DocumentReference task) async{
    return await task.delete();
  }


  //get Stream of Lists
  Stream<List<TaskList>>? get lists {
    return listCollection.where('ownerId',isEqualTo: uid).snapshots().map(_taskListFromSnapshot);
  }

 

  //TaskList from Snapshot
  List<TaskList> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return TaskList(
        ownerId: doc.get('ownerId'),
        bezeichnung: doc.get('bezeichnung'),
        icon: IconData(doc.get('icon'), fontFamily: 'MaterialIcons'),
      );
    }
    ).toList();
  }

  //get Stream of Tasks
  Stream<List<Task>> get tasks{
    return taskCollection.where('ownerId',isEqualTo: uid).snapshots().map(_taskFromSnapshot);
  }




  List<Task> _taskFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
        bezeichnung: doc.get('bezeichnung'),
        notiz: doc.get('notiz'),
        prioritaet: doc.get('priorität'),
        faelligkeitsdatum: doc.get('datum'),
        creationDate: doc.get('wiedervorlagedatum'),
        ownerId: doc.get('ownerId')

      );
    }).toList();

  }
    // task appUser from Snapshot
  // List<appUser> _taskListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.docs.map((doc) {
  //     return appUser(
  //       displayName: doc.get('displayName') ?? '' , // if value is null return empty string
  //       email: doc.get('email') ?? '', 
  //     );
  //   }).toList();
  // }
}