import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/taskTile.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';

class ListOfTasks extends StatefulWidget {
  const ListOfTasks({super.key});

  @override
  State<ListOfTasks> createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {
  @override
  Widget build(BuildContext context) {

    final tasks = Provider.of<List<Task>?>(context);
    print(tasks);
    for (Task task in tasks!){
      print(task.description);
    }
    return Container();

    

    // return tasks == null ? Loading() : ListView.builder(
    //   shrinkWrap: true,
    //   physics: const BouncingScrollPhysics(),
    //   itemCount: tasks.length,
    //   itemBuilder: (context, index){
    //     return TaskTile(task: tasks[index]);
    //   },

    // );
  }
}