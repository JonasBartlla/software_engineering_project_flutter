import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';

class ListOfTasks extends StatefulWidget {
  
  final List<Task> tasks;
  const ListOfTasks({required this.tasks, super.key});

  @override
  State<ListOfTasks> createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {
  @override
  Widget build(BuildContext context) {

    late List<Task> tasks = widget.tasks;

    //final tasks = Provider.of<List<Task>?>(context);
    //final List<Task> filteredTasks = tasks!.where((task) => task.list == list).toList();

    // print(tasks);
    // for (Task task in tasks!){
    //   print(task.description);
    // }

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