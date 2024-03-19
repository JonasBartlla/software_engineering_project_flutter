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

  late List<Task> tasks;

  @override
  Widget build(BuildContext context) {

    //late List<Task> tasks = widget.tasks;
    switch(widget.listDescription){
      case 'Alle ToDos':
        tasks = Provider.of<List<Task>>(context);
      case 'Erledigte ToDos':
        tasks = Provider.of<List<Task>>(context).where((element){
          return element.done == true;
        }).toList();
      case 'Mein Tag':
        tasks = Provider.of<List<Task>>(context).where((element){
          DateTime rightNow = DateTime.now();
          if (element.maturityDate.isAfter(DateTime(rightNow.year,rightNow.month,rightNow.day)) && element.maturityDate.isBefore(DateTime(rightNow.year,rightNow.month,rightNow.day+1))){
            return true;
          }else{
            return false;
          }
        }).toList();
      default:
        tasks = Provider.of<List<Task>>(context).where((element){
                  return element.list == widget.listDescription ? true : false;
                }).toList();

    }
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