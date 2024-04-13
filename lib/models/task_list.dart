import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskList {
  String description;
  IconData icon;
  Color iconColor;
  DateTime creationDate;
  String ownerId;
  bool isEditable;
  DocumentReference listReference;

  TaskList({required this.description, required this.icon, required this.iconColor, required this.creationDate , required this.ownerId, required this.isEditable, required this.listReference});

}