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

  final priorityDict = {"keine Priorität" :0,"Niedrig": 1, "Mittel": 2, "Hoch": 3}; 

  //final CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('taskCollection');



  Future updateUserDate(String uid, String? displayName, String? email) async {
    return await userCollection.doc(uid).set(
      {
        'uid': uid,
        'displayName': displayName,
        'email': email,
      }
    );
  }

  Future<void> updateToken(String uid, String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  Stream<List<appUser>>? get appUsers {
    return userCollection.where('uid',isEqualTo: uid).snapshots().map(_appUserFromSnapshot); 
  }

  List<appUser> _appUserFromSnapshot (QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return appUser(uid: doc.get('uid'), displayName: doc.get('displayName'), email: doc.get('email'));
    } ).toList();
  }

  //   List<TaskList> _taskListFromSnapshot(QuerySnapshot snapshot){
  //   return snapshot.docs.map((doc){
  //     return TaskList(     
  //       description: doc.get('description'),
  //       icon: IconData(doc.get('icon'), fontFamily: 'MaterialIcons'),
  //       creationDate: DateTime.fromMillisecondsSinceEpoch(doc.get('creationDate')),
  //       ownerId: doc.get('ownerId'),
  //       isEditable: doc.get('isEditable'),
  //       listReference: doc.reference
  //     );
  //   }
  //   ).toList();
  // }

  Future initializeCollection() async {
    await addList("Mein Tag", Icons.calendar_month_rounded, Colors.white, isEditable: false);
    await addList("Alle ToDos", Icons.house_rounded, Colors.white, isEditable: false);
    return await addList("Erledigte ToDos", Icons.check_circle_outline_rounded, Colors.white, isEditable: false);
  }

  //add List
  Future addList(String description, IconData icon, Color iconColor, {bool isEditable = true}) async {
    return await listCollection.add({
      'description': description,
      'icon': icon.codePoint,
      'iconColor': iconColor.value,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
      'isEditable': isEditable,
      'ownerId': uid,
    });
  }

  //editing List
  Future editList(String bezeichnung, IconData icon, Color iconColor, DocumentReference list, DateTime creationDate, bool isEditable, String ownerId) async {
    return await list.set({
      'description': bezeichnung,
      'icon': icon.codePoint,
      'iconColor': iconColor.value,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'isEditable': isEditable,
      'ownerId': ownerId,
    });
  }

  //deleting List
  Future deleteList(DocumentReference list, String listName) async {
    //get all Tasks of affected List
    QuerySnapshot tasksOfList = await taskCollection.where('ownerId',isEqualTo: uid).get();
    List<DocumentReference> taskReferences = tasksOfList.docs.where((doc) {
      return doc.get('list') == listName;
    }).map((doc){
      return doc.reference;
    }).toList();
    for(DocumentReference taskReference in taskReferences){
      deleteTask(taskReference);
    }
    return await list.delete();
  }

  Future<List<String>> getAvailableListForUser({bool addInitialLists = false}) async {
    QuerySnapshot snapshot = await listCollection.where('ownerId',isEqualTo: uid).get(); //Filter all list of user
    List<String> lists = snapshot.docs.where((list){ //filter all editableList of user
      return list.get('isEditable') == true;
    })
    .map((e){ // get description of Lists
      return e.get('description') as String;
    }).toList();
    lists.add('keine Liste');
    if(addInitialLists){
      lists.add('Mein Tag');
      lists.add('Alle ToDos');
      lists.add('Erledigte ToDos');
    }
    return lists;
  }

  //add Task
  Future addTask(String description, String note, DateTime maturityDate, bool notificationOn, int priority, List<DocumentReference>? lists, bool done, String list) async {
    //adding the Task
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


  //get Stream of Lists
  Stream<List<TaskList>>? get lists {
    return listCollection.where('ownerId',isEqualTo: uid).orderBy('creationDate').snapshots().map(_taskListFromSnapshot);
  }

 

  //TaskList from Snapshot
  List<TaskList> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return TaskList(     
        description: doc.get('description'),
        icon: IconData(doc.get('icon'), fontFamily: 'MaterialIcons'),
        iconColor: Color(doc.get('iconColor')),
        creationDate: DateTime.fromMillisecondsSinceEpoch(doc.get('creationDate')),
        ownerId: doc.get('ownerId'),
        isEditable: doc.get('isEditable'),
        listReference: doc.reference
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