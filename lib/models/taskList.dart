import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskList {

  String ownerId;
  String bezeichnung;
  IconData icon;
  // List<String> associated;

  TaskList({required this.ownerId, required this.bezeichnung, required this.icon});

}