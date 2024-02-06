

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/models/list_tile.dart';
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
      physics: const BouncingScrollPhysics(),
      itemCount: lists.length,
      itemBuilder: (context, index) {
        return ListTileTest(taskList: lists[index]);
      },

    );
  }
}