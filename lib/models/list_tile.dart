import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/edit_list_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/view_tasks_screen.dart';
import 'package:software_engineering_project_flutter/shared/percent_indicator.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ListTileTest extends StatelessWidget {
  final TaskList taskList;

  const ListTileTest({required this.taskList, super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>?>(context);

    int getCounter(TaskList taskList) {
      if (taskList.description == "Mein Tag") {
        DateTime now = DateTime.now();
        return tasks!
            .where((task) =>
                task.maturityDate.year == now.year &&
                task.maturityDate.month == now.month &&
                task.maturityDate.day == now.day && 
                task.done == false)
            .toList()
            .length; //hier nach Datum schauen
      } else if (taskList.description == "Erledigte ToDos") {
        return tasks!.where((task) => task.done == true).toList().length;
      } else if (taskList.description == "Alle ToDos") {
        return tasks!.where((task) => task.done == false).toList().length;
      } else {
        return tasks!
            .where((task) => task.list == taskList.description && task.done == false)
            .toList()
            .length;
      }
    }
    double getProgressPercent(TaskList tasklist){
      double progress;
      if (tasklist.description == "Mein Tag"){
        DateTime now = DateTime.now();
        progress = tasks!
            .where((task) =>
                task.maturityDate.year == now.year &&
                task.maturityDate.month == now.month &&
                task.maturityDate.day == now.day && 
                task.done == true)
            .toList()
            .length.toDouble() / tasks!
            .where((task) =>
                task.maturityDate.year == now.year &&
                task.maturityDate.month == now.month &&
                task.maturityDate.day == now.day)
            .toList()
            .length.toDouble();
      }
      else if (taskList.description == "Alle ToDos") {
        progress = tasks!.where((task) => task.done == true).toList().length.toDouble() / tasks!.toList().length.toDouble();
        } else {
        progress = tasks!
            .where((task) => task.list == taskList.description && task.done == true)
            .toList()
            .length.toDouble() / tasks!
            .where((task) => task.list == taskList.description)
            .toList()
            .length.toDouble();
      }
      if (progress.isNaN){
        return 2;
      }
      return progress;
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 10,
        color: AppColors.myCheckITDarkGrey,
        surfaceTintColor: AppColors.myCheckITDarkGrey,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: SizedBox(
          height: 30,
          width: 30,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ListTile(
                  onTap: () {
                    if (taskList.description != 'default') {
                      final List<Task> filteredTasks = tasks!
                          .where((task) => task.list == taskList.description)
                          .toList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ListOfTasksPage(
                                  tasks: filteredTasks, taskList: taskList))));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ListOfTasksPage(
                                  tasks: tasks!, taskList: taskList))));
                    }
                  },
                  contentPadding: EdgeInsets.all(8.0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        taskList.icon,
                        color: AppColors.myCheckItGreen,
                        size: 48.0,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        taskList.description,
                        style: standardHeadlineDecoration,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.0),
                      taskList.description == "Erledigte ToDos" || getProgressPercent(taskList) == 2? SizedBox(): CheckITPercentIndicator(progressPercent: getProgressPercent(taskList))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                      child: Text(
                    getCounter(taskList).toString(),
                    style: standardTextDecoration.copyWith(color: Colors.black),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
