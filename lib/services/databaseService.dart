import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:software_engineering_project_flutter/models/appUser.dart';
import "package:software_engineering_project_flutter/models/taskList.dart";

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

  Future addTask(String bezeichnung, String notiz, DateTime selectedDate, String priority, List<DocumentReference>? lists) async {
    //adding the Task
    DocumentReference task = await taskCollection.add({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'datum': selectedDate.millisecondsSinceEpoch,
      'wiedervorlagedatum': Timestamp.fromDate(DateTime.now()),
      'priorität': priority,
      'owner_id': uid
    }); 
    //adding references
    return await updateTaskListReferences(task: task,lists: lists);
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

  Future updateTaskListReferences({DocumentReference? task, List<DocumentReference>? lists}) async {
    if (task == null){
      print('Task is null');
      // QuerySnapshot<DocumentReference> existingReferences = await referenceCollection.where('userReference', isEqualTo: task).get();
      // List<DocumentReference> existingRef = existingReferences.docs.map((doc) => doc.data()).toList();
      //remove all references where the list appears
    } else if(lists == null){
      print('List is null');
      //remove all references where the task appears
    } else{
      print('none is null');
      //update references
    }
    
    return 1;
  }
  // get user Stream
  // Stream<List<appUser>> get users {
  //   return userCollection.snapshots().map(_taskListFromSnapshot);
  // }

  void test(){
    print(Timestamp.fromDate(DateTime.now()));
  }

  //get Stream of Lists
  Stream<List<TaskList>>? get lists {
    return listCollection.snapshots().map(_taskListFromSnapshot);
  }

 

  //TaskList from Snapshot
  List<TaskList> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return TaskList(
        bezeichnung: doc.get('bezeichnung'),
        icon: IconData(doc.get('icon'), fontFamily: 'MaterialIcons'),
        taskCounter: doc.get('taskCounter') ?? 0,
        listReference: doc.reference);
    }
    ).toList();
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