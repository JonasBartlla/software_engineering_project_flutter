import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';

class ListOfTasks extends StatefulWidget {
  
  final String listDescription;
  const ListOfTasks({required this.listDescription, super.key});

  @override
  State<ListOfTasks> createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {
  @override
  Widget build(BuildContext context) {

    //late List<Task> tasks = widget.tasks;
    List<Task> tasks = Provider.of<List<Task>>(context).where((element){
      return element.list == widget.listDescription ? true : false;
    }).toList();
    return tasks == null ? Loading() : ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index){
        return TaskTile(task: tasks[index], done: tasks[index].done,);
      },

    );
  }
}