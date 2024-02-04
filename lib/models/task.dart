import 'package:cloud_firestore/cloud_firestore.dart';

class Task{

  String bezeichnung;
  String notiz;
  //String zugehoerigeListe;
  String prioritaet;
  //String? wiederholung;
  DateTime faelligkeitsdatum;
  bool benachrichtigung;
  String ownerId;
  DateTime creationDate;
  bool done;
  DocumentReference taskReference;


  Task({required this.bezeichnung, required this.notiz, required this.prioritaet, required this.faelligkeitsdatum, required this.benachrichtigung, required this.ownerId, required this.creationDate, required this.done, required this.taskReference});

}