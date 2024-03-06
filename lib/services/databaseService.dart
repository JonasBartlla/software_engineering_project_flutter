import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:software_engineering_project_flutter/models/app_user.dart';
import "package:software_engineering_project_flutter/models/task_list.dart";
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

  final priorityDict = {"no priority":0,"Niedrig": 1, "Mittel": 2, "Hoch": 3}; 

  //final CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('taskCollection');



  Future updateUserDate(String displayName, String? email) async {
    return await userCollection.doc(uid).set(
      {
        'displayName': displayName,
        'email': email,
      }
    );
  }

  //add List
  Future addList(String description, IconData icon) async {
    return await listCollection.add({
      'description': description,
      'icon': icon.codePoint,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
      'ownerId': uid,
    });
  }

  //editing List
  Future editList(String bezeichnung, IconData icon, DocumentReference list, DateTime creationDate, String ownerId) async {
    return await list.set({
      'description': bezeichnung,
      'icon': icon.codePoint,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'ownerId': ownerId,
    });
  }

  //deleting List
  Future deleteList(DocumentReference list) async {
    return await list.delete();
  }

    //get Stream of Lists
  Stream<List<TaskList>>? get lists {
    return listCollection.where('ownerId',isEqualTo: uid).snapshots().map(_taskListFromSnapshot);
  }

 

  //TaskList from Snapshot
  List<TaskList> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return TaskList(     
        description: doc.get('description'),
        icon: IconData(doc.get('icon'), fontFamily: 'MaterialIcons'),
        creationDate: DateTime.fromMillisecondsSinceEpoch(doc.get('creationDate')),
        ownerId: doc.get('ownerId'),
      );
    }
    ).toList();
  }

  //add Task
  Future addTask(String description, String note, DateTime maturityDate, bool notificationOn, int priority, List<DocumentReference>? lists, bool done, String list) async {
    //adding the Task
    print(priority);
   
    return  await taskCollection.add({
      'description': description,
      'note': note,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
      'notificationOn': notificationOn,
      'maturityDate': maturityDate.millisecondsSinceEpoch,
      'priority': priority,
      'ownerId': uid,
      'done': done,
      'list': list
    }); 
  }

  Future editTask(String description, String note, DateTime creationDate, bool notificationOn, DateTime maturityDate, int priority, String list, bool done, String ownerId, DocumentReference taskId) async {
    return await taskId.set({
      'description': description,
      'note': note,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'notificationOn': notificationOn,
      'maturityDate': maturityDate.millisecondsSinceEpoch,
      'priority': priority,
      'done': done,
      'list': list,
      'ownerId': uid
    }); 
  }

  // deletion of task
  Future deleteTask(DocumentReference task) async{
    return await task.delete();
  }

  //get Stream of Tasks
  Stream<List<Task>> get tasks{
    return taskCollection.where('ownerId',isEqualTo: uid).snapshots().map(_taskFromSnapshot);
  }

  List<Task> _taskFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
        description: doc.get('description'),
        note: doc.get('note'),
        priority: doc.get('priority'),
        maturityDate: DateTime.fromMillisecondsSinceEpoch(doc.get('maturityDate')),
        notificationOn: doc.get('notificationOn'),
        creationDate: DateTime.fromMillisecondsSinceEpoch(doc.get('creationDate')),
        ownerId: doc.get('ownerId'),
        done: doc.get('done'),
        list: doc.get('list'),
        taskReference: doc.reference
      );
    }).toList();
  }

  String getPriority(int priority){
    return priorityDict.keys.firstWhere(
          (element) => priorityDict[element] == priority);
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