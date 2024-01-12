import "package:cloud_firestore/cloud_firestore.dart";
import "package:software_engineering_project_flutter/models/appUSer.dart";

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

  // task list from Snapshot
  List<appUser> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return appUser(
        name: doc.get('name') ?? '' , // if value is null return empty string
        hobby: doc.get('hobby') ?? '', 
        age: doc.get('age') ?? 0);
    }).toList();
  }

  // get user Stream
  Stream<List<appUser>> get users {
    return userCollection.snapshots().map(_taskListFromSnapshot);
  }


}