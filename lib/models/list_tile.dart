import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/edit_list_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/view_tasks_screen.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ListTileTest extends StatelessWidget {
  final TaskList taskList;

  const ListTileTest({required this.taskList, super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>?>(context);
     int counter = tasks!
        .where((task) => task.list == taskList.description)
        .toList()
        .length;

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 4,
        color: AppColors.myCheckITDarkGrey,
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
                  child: Center(child: Text(counter.toString(), style: TextStyle(fontSize: 18),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
