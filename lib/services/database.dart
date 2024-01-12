import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:software_engineering_project_flutter/models/appUser.dart';

class DatabaseService{
  //collection reference

  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference listCollection =  FirebaseFirestore.instance.collection('lists');
  final CollectionReference taskCollection =  FirebaseFirestore.instance.collection('lists');


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
  Future createNewTask(String bezeichnung, String notiz, String zugehoerigeListe, String prioritaet, String wiederholung, DateTime faelligkeitsdatum) {
    return taskCollection.add(
      {
        'bezeichnung'[0] = bezeichnung,
      }
    );
  }


  // get user Stream
  Stream<List<appUser>> get users {
    return userCollection.snapshots().map(_taskListFromSnapshot);
  }


}