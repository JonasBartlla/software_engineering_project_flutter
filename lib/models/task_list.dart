import 'package:flutter/material.dart';

class TaskList {
  String description;
  IconData icon;
  DateTime creationDate;
  String ownerId;
  

  // List<String> associated;

  TaskList({required this.description, required this.icon, required this.creationDate , required this.ownerId});

}