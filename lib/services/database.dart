import "package:cloud_firestore/cloud_firestore.dart";
import "package:software_engineering_project_flutter/models/task.dart";

class DatabaseService{
  //collection reference

  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference checkCollection = FirebaseFirestore.instance.collection('users');


  Future updateUserDate(String name, String hobby, int age) async {
    return await checkCollection.doc(uid).set(
      {
        'name': name,
        'hobby': hobby,
        'age': age,
      }
    );
  }

  // task list from Snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Task(
        name: doc.get('name') ?? '' , // if value is null return empty string
        hobby: doc.get('hobby') ?? '', 
        age: doc.get('age') ?? 0);
    }).toList();
  }

  // get user Stream
  Stream<List<Task>> get users {
    return checkCollection.snapshots().map(_taskListFromSnapshot);
  }


}