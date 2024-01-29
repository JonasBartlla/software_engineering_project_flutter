import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskList {

  String bezeichnung = '';
  IconData icon;
  int taskCounter;
  DocumentReference listReference;

  TaskList({required this.bezeichnung, required this.icon, required this.taskCounter, required this.listReference});

}