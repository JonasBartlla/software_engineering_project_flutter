import "dart:async";
import "package:cloud_firestore/cloud_firestore.dart";
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
  late final CollectionReference notificationCollection;
  DatabaseService({this.uid}){
    userCollection = FirebaseFirestore.instance.collection('users');
    listCollection = FirebaseFirestore.instance.collection('lists');
    taskCollection = FirebaseFirestore.instance.collection('tasks');
    notificationCollection = FirebaseFirestore.instance.collection('notification');
  }

  final priorityDict = {"keine Priorität" :0,"Niedrig": 1, "Mittel": 2, "Hoch": 3}; 

  //final CollectionReference userCollection = FirebaseFirestore.instance.collection('users').doc(uid).collection('taskCollection');



  Future updateUserDate(String uid, String? displayName, String? email, String? imageUrl) async {
    return await userCollection.doc(uid).set(
      {
        'uid': uid,
        'displayName': displayName,
        'email': email,
        'profileUrl': imageUrl
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
      return appUser(uid: doc.get('uid'), displayName: doc.get('displayName'), email: doc.get('email'), imageUrl: doc.get('profileUrl'));
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

  Future<void> cleanUpUser(String uid)async{
    //cleanup notifications
    QuerySnapshot snapshot = await notificationCollection.where('ownerId', isEqualTo: uid).get();
    snapshot.docs.forEach((notification) { 
      notification.reference.delete();
    });
    //cleanup tasks
    snapshot = await taskCollection.where('ownerId', isEqualTo: uid).get();
    snapshot.docs.forEach((task) { 
      task.reference.delete();
    }); 
    //cleanup lists
    snapshot = await listCollection.where('ownerId', isEqualTo: uid).get();
    snapshot.docs.forEach((list) { 
      list.reference.delete();
    }); 
    return await userCollection.doc(uid).delete(); //delete entry in user
  }

  //add Task
  Future addTask(String description, String note, DateTime maturityDate, int priority, List<DocumentReference>? lists, bool done, String list) async {
    //adding the Task
    DocumentReference  task =await taskCollection.add({
      'description': description,
      'note': note,
      'creationDate': DateTime.now().millisecondsSinceEpoch,
      'maturityDate': maturityDate.millisecondsSinceEpoch,
      'priority': priority,
      'ownerId': uid,
      'done': done,
      'list': list
    }); 

    if(maturityDate.isAfter(DateTime.now())){
      addNotification(uid!, task.id, maturityDate);
    }
    return task;
  }

  Future addNotification(String ownerId, String taskId, DateTime maturityDate, {bool messageSent = false}) async {
    return await notificationCollection.add({
      'ownerId' : ownerId,
      'taskId': taskId,
      'maturityDate': maturityDate.millisecondsSinceEpoch,
      'messageSent':  messageSent
    });
  }

  Future editTask(String description, String note, DateTime creationDate, DateTime maturityDate, int priority, String list, bool done, String ownerId, DocumentReference taskId) async {
    if(maturityDate.isBefore(DateTime.now()) || done){
      deleteNotification(taskId.id);
    }else{
      updateNotification(taskId.id, maturityDate);
    }
    return await taskId.set({
      'description': description,
      'note': note,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'maturityDate': maturityDate.millisecondsSinceEpoch,
      'priority': priority,
      'done': done,
      'list': list,
      'ownerId': uid
    }); 
  }

  Future updateTaskOfLists(String oldListname, String newListname) async {
    QuerySnapshot snapshot = await taskCollection.where('ownerId', isEqualTo: uid).where('list', isEqualTo: oldListname ).get();
    snapshot.docs.forEach((doc) {
      doc.reference.update({'list': newListname});
     });
  }

  Future<void> updateNotification(String taskId, DateTime maturityDate)async{
    QuerySnapshot notificationDocument = await notificationCollection.where('taskId', isEqualTo: taskId).get();
    print(notificationDocument.size);
    if(notificationDocument.size == 0){
      addNotification(uid!, taskId, maturityDate);
    }else{
      notificationDocument.docs.forEach((element) 
      {
        element.reference.update({'maturityDate': maturityDate.millisecondsSinceEpoch, 'messageSent': false});
      }
      );
    }
    return;
  }

  Future<void> deleteNotification(String taskId)async{
    QuerySnapshot notificationDocument = await notificationCollection.where('taskId', isEqualTo: taskId).get();
    notificationDocument.docs.forEach((element) {
      element.reference.delete();
    });
    return;
  }

  // deletion of task
  Future deleteTask(DocumentReference task) async{
    deleteNotification(task.id);
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