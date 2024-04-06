import 'package:cloud_firestore/cloud_firestore.dart';

class Task{

  String description;
  String note;
  String list;
  int priority;
  //String? wiederholung;
  DateTime maturityDate;
  String ownerId;
  DateTime creationDate;
  bool done;
  DocumentReference taskReference;


  Task({required this.description, required this.note, required this.priority, required this.list, required this.maturityDate, required this.ownerId, required this.creationDate, required this.done, required this.taskReference});

}