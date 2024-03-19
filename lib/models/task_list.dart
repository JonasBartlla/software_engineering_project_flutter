import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskList {
  String description;
  IconData icon;
  DateTime creationDate;
  String ownerId;
  DocumentReference listReference;

  // List<String> associated;

  TaskList({required this.description, required this.icon, required this.creationDate , required this.ownerId, required this.listReference});

}