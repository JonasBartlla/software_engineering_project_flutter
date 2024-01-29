

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/taskList.dart';
import 'package:software_engineering_project_flutter/models/listTileTest.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';

class ListOfTaskLists extends StatefulWidget {
  const ListOfTaskLists({super.key});

  @override
  State<ListOfTaskLists> createState() => _ListOfTaskListsState();
}


class _ListOfTaskListsState extends State<ListOfTaskLists> {
  @override
  Widget build(BuildContext context) {

    final lists = Provider.of<List<TaskList>?>(context);

    return  lists == null ? Loading() : ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: lists.length,
      itemBuilder: (context, index) {
        return ListTileTest(taskList: lists[index]);
      },

    );
  }
}