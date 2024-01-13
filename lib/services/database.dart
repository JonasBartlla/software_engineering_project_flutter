import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:software_engineering_project_flutter/models/appUser.dart';

class DatabaseService{
  //collection reference

  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  
  final CollectionReference listCollection =  FirebaseFirestore.instance.collection('lists');

  final CollectionReference taskCollection =  FirebaseFirestore.instance.collection('tasks');


  Future updateUserDate(String displayName, String? email) async {
    return await userCollection.doc(uid).set(
      {
        'displayName': displayName,
        'email': email,
      }
    );
  }

  // task appUser from Snapshot
  List<appUser> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return appUser(
        displayName: doc.get('displayName') ?? '' , // if value is null return empty string
        email: doc.get('email') ?? '', 
      );
    }).toList();
  }

  //add List
  Future addList(String bezeichnung, IconData icon) async {
    return await userCollection.doc(uid).collection('lists').add({
      'bezeichnung': bezeichnung,
      'icon': icon.codePoint,
      'taskCounter': 0
    });
     //IconData(iconCodePointFromDataBase, fontFamily: 'MaterialIcons')
  }

  

  //add Task
  Future addTask(String bezeichnung, String notiz, DateTime selectedDate, TimeOfDay uhrzeit, String priority, String listId) async {
    return await userCollection.doc(uid).collection('lists').doc(listId).collection('tasks').add({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'datum': selectedDate.toString(),
      'uhrzeit': uhrzeit.toString(),
      'priorität': priority
    }); 
   }

  // get user Stream
  // Stream<List<appUser>> get users {
  //   return userCollection.snapshots().map(_taskListFromSnapshot);
  // }


}