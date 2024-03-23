import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/models/sort_fields.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/view_tasks_screen.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/sorting_algorithm.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ListOfTasks extends StatefulWidget {
  final String listDescription;
  const ListOfTasks({required this.listDescription, super.key});

  @override
  State<ListOfTasks> createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {
  late List<Task> tasks;

  SortFields selectedValue = SortFields("Sortieren", Icons.swap_vert);
  static List<SortFields> fields = [
    SortFields("Erstellungsdatum", Icons.arrow_upward_sharp),
    SortFields("Erstellungsdatum", Icons.arrow_downward_sharp),
    SortFields("Priorität", Icons.arrow_upward_sharp),
    SortFields("Priorität", Icons.arrow_downward_sharp),
    SortFields("Fälligkeit", Icons.arrow_upward_sharp),
    SortFields("Fälligkeit", Icons.arrow_downward_sharp)
  ];

  @override
  Widget build(BuildContext context) {
    //late List<Task> tasks = widget.tasks;
    switch (widget.listDescription) {
      case 'Alle ToDos':
        tasks = Provider.of<List<Task>>(context);
      case 'Erledigte ToDos':
        tasks = Provider.of<List<Task>>(context).where((element) {
          return element.done == true;
        }).toList();
      case 'Mein Tag':
        tasks = Provider.of<List<Task>>(context).where((element) {
          DateTime rightNow = DateTime.now();
          if (element.maturityDate.isAfter(
                  DateTime(rightNow.year, rightNow.month, rightNow.day)) &&
              element.maturityDate.isBefore(
                  DateTime(rightNow.year, rightNow.month, rightNow.day + 1))) {
            return true;
          } else {
            return false;
          }
        }).toList();
      default:
        tasks = Provider.of<List<Task>>(context).where((element) {
          return element.list == widget.listDescription ? true : false;
        }).toList();
    }

    //Sortieralgorithmus
    if (selectedValue == fields[0]) {
      tasks.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } else if (selectedValue == fields[1]) {
      tasks.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    } else if (selectedValue == fields[2]) {
      tasks.sort((a, b) => b.priority.compareTo(a.priority));
    } else if (selectedValue == fields[3]) {
      tasks.sort((a, b) => a.priority.compareTo(b.priority));
    } else if (selectedValue == fields[4]) {
      tasks.sort((a, b) => a.maturityDate.compareTo(b.maturityDate));
    } else if (selectedValue == fields[5]) {
      tasks.sort((a, b) => b.maturityDate.compareTo(a.maturityDate));
    }

    tasks.sort((a, b) => a.done ? 1 : -1);

    //tasks = sortTasks(tasks, selectedValue);

    if (tasks == null) {
      return Loading();
    } else if (tasks.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.lightbulb,
            size: 35,
            color: AppColors.myAbbrechenColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Ganz schön leer hier...',
            style: standardTextDecoration.copyWith(
                color: AppColors.myAbbrechenColor, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Du kannst unten ein ToDo erstellen',
            style: standardTextDecoration.copyWith(
                color: AppColors.myAbbrechenColor, fontSize: 20),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PhysicalModel(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular((8)),
                  color: AppColors.myCheckITDarkGrey,
                  elevation: 8,
                  shadowColor: AppColors.myShadowColor,
                  child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.myCheckITDarkGrey),
                      child: DropdownButton<SortFields>(
                        icon: const Icon(
                          Icons.swap_vert,
                          color: AppColors.myCheckITDarkGrey,
                        ),
                        underline: const SizedBox(),
                        elevation: 10,
                        borderRadius: BorderRadius.circular(8),
                        dropdownColor: AppColors.myCheckITDarkGrey,
                        hint: Row(children: [
                          Icon(
                            selectedValue.icon,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            selectedValue.sortCriteria,
                            style: const TextStyle(color: Colors.white),
                          )
                        ]),
                        onChanged: (SortFields? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: fields.map((SortFields field) {
                          return DropdownMenuItem<SortFields>(
                              value: field,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    field.icon,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    field.sortCriteria,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ));
                        }).toList(),
                      )),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: tasks[index],
                  done: tasks[index].done,
                  listDescription: widget.listDescription,
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
