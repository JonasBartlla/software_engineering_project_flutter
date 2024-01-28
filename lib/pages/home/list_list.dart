

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/list.dart';

class ListOfTaskLists extends StatefulWidget {
  const ListOfTaskLists({super.key});

  @override
  State<ListOfTaskLists> createState() => _ListOfTaskListsState();
}


class _ListOfTaskListsState extends State<ListOfTaskLists> {
  @override
  Widget build(BuildContext context) {

    final lists = Provider.of<List<TaskList>?>(context);
    print("a");
    if (lists != null){
      for (var taskList in lists){
        print("b");
        print(taskList.bezeichnung + " " + taskList.listReference.toString() + " " + taskList.taskCounter.toString());
      }
    }
    return const Placeholder();
  }
}