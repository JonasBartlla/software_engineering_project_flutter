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


  // Future testListReferences() async {
  //   return await addList(bezeichnung, icon)
  // }

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
    List<DocumentReference> taskList = [userCollection.doc(uid).collection('lists').doc('kategorie').collection('tasks').doc('XLf5hhX023CxDYsSOEdu'),userCollection.doc(uid).collection('lists').doc('kategorie').collection('tasks').doc('sLt8vpdfDMkHmVfKA6L3')];

    return await userCollection.doc(uid).collection('lists').add({
      'bezeichnung': bezeichnung,
      'icon': icon.codePoint,
      'taskCounter': taskList.length,
      'taskRefrences': taskList
    });
     //IconData(iconCodePointFromDataBase, fontFamily: 'MaterialIcons')
  }

  

  //add Task
  Future addTask(String bezeichnung, String notiz, DateTime selectedDate, TimeOfDay uhrzeit, String priority, String listId) async {
    print(bezeichnung);
    print(notiz);
    print(selectedDate);
    print(uhrzeit);
    print(priority);
    print(listId);
    return await userCollection.doc(uid).collection('lists').doc(listId).collection('tasks').add({
      'bezeichnung': bezeichnung,
      'notiz': notiz,
      'wiedervorlagedatum': Timestamp.fromDate(selectedDate),
      'uhrzeit': uhrzeit.toString(),
      'priorität': priority
    }); 
   }

  // get user Stream
  // Stream<List<appUser>> get users {
  //   return userCollection.snapshots().map(_taskListFromSnapshot);
  // }

  void test(){
    print(Timestamp.fromDate(DateTime.now()));
  }
}