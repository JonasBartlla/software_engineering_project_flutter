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

  //add Task 
  // Future addTask(String bezeichnung, String notiz, String kategorie, DateTime selectedDate, TimeOfDay uhrzeit, String priority, String listId) async {
  //   return await userCollection.doc(uid).collection('lists').doc(listId).collection("");



  //   // FirebaseAuth auth = FirebaseAuth.instance;
  //   // final User? user = await auth.currentUser;
  //   // String uid = user!.uid;
  //   // //var time = DateTime.now();
  //   // await FirebaseFirestore.instance.collection('tasks')
  //   // .doc(uid)
  //   // //.collection('mytasks')
  //   // //.doc(time.toString())
  //   // .set({
  //   //   'bezeichnung': bezeichnung,
  //   //   'notiz': notiz,
  //   //   'kategorie': kategorie,
  //   //   'datum': selectedDate.toString(),
  //   //   'uhrzeit': uhrzeit.toString(),
  //   //   'priorität': priority
  //   //   });
  // }

  //add List
  Future addList(String bezeichnung, IconData icon, List<String> lists) async {
    return await userCollection.doc(uid).collection('lists').add({
      'bezeichnung': bezeichnung,
      'multipleLists': lists,
      'icon': icon.codePoint
    });
     //IconData(iconCodePointFromDataBase, fontFamily: 'MaterialIcons')
    // return await taskCollection.add({
    //   'bezeichnung': bezeichnung,
    //   'fk_user': uid 
    // });

  }

  

  //add Task
  // Future addTask(String bezeichnung, String notiz, String kategorie, DateTime selectedDate, TimeOfDay uhrzeit, String priority, String listId) async {
  //   return await 
  // }

  // get user Stream
  // Stream<List<appUser>> get users {
  //   return userCollection.snapshots().map(_taskListFromSnapshot);
  // }


}