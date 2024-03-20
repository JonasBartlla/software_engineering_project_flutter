import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/edit_list_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/list_of_tasks_widget.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ListOfTasksPage extends StatefulWidget {
  final List<Task> tasks;
  // final String list;
  // final IconData icon;
  final TaskList taskList;
  const ListOfTasksPage(
      {required this.tasks, required this.taskList, super.key});

  @override
  State<ListOfTasksPage> createState() => _ListOfTaskPageState();
}

class SortFields {
  String sortCriteria;
  IconData icon;

  SortFields(this.sortCriteria, this.icon);
}

class _ListOfTaskPageState extends State<ListOfTasksPage> {
  SortFields selectedValue = SortFields("Sortieren", Icons.swap_vert);
  final List<SortFields> fields = [
    SortFields("Erstellungsdatum", Icons.arrow_upward_sharp),
    SortFields("Erstellungsdatum", Icons.arrow_downward_sharp),
    SortFields("Priorität", Icons.arrow_upward_sharp),
    SortFields("Priorität", Icons.arrow_downward_sharp),
    SortFields("Fälligkeit", Icons.arrow_upward_sharp),
    SortFields("Fälligkeit", Icons.arrow_downward_sharp)
  ];

  @override
  Widget build(BuildContext context) {
    late List<Task> tasks = widget.tasks;
    late TaskList taskList = widget.taskList;
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return StreamProvider<List<Task>>.value(
      initialData: [],
      value: _database.tasks,
      child: Scaffold(
        backgroundColor: AppColors.myBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.myCheckItGreen,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.myBackgroundColor,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Icon(
            taskList.icon,
            color: AppColors.myBackgroundColor,
            size: 40,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                child: Text(
                  taskList.description,
                  style: const TextStyle(
                      color: AppColors.myTextColor, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
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
                          icon: Icon(
                            Icons.swap_vert,
                            color: AppColors.myCheckITDarkGrey,
                          ),
                          underline: SizedBox(),
                          elevation: 10,
                          borderRadius: BorderRadius.circular(8),
                          dropdownColor: AppColors.myCheckITDarkGrey,
                          hint: Row(children: [
                            Icon(
                              selectedValue.icon,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              selectedValue.sortCriteria,
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                          onChanged: (SortFields? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                              if (newValue == fields[0]) {
                                tasks.sort((a, b) {
                                  if (a.creationDate != b.creationDate) {
                                    return b.creationDate
                                        .compareTo(a.creationDate);
                                  } else {
                                    return b.creationDate
                                        .compareTo(a.creationDate);
                                  }
                                });
                              }
                              if (newValue == fields[1]) {
                                tasks.sort((a, b) {
                                  if (a.creationDate != b.creationDate) {
                                    return a.creationDate
                                        .compareTo(b.creationDate);
                                  } else {
                                    return a.creationDate
                                        .compareTo(b.creationDate);
                                  }
                                });
                              }
                              if (newValue == fields[2]) {
                                tasks.sort((a, b) {
                                  if (a.priority != b.priority) {
                                    return b.priority.compareTo(a.priority);
                                  } else {
                                    return b.priority.compareTo(a.priority);
                                  }
                                });
                              }
                              if (newValue == fields[3]) {
                                tasks.sort((a, b) {
                                  if (a.priority != b.priority) {
                                    return a.priority.compareTo(b.priority);
                                  } else {
                                    return a.priority.compareTo(b.priority);
                                  }
                                });
                              }
                              if (newValue == fields[4]) {
                                tasks.sort(
                                  (a, b) {
                                    if (a.maturityDate != b.maturityDate) {
                                      return a.maturityDate
                                          .compareTo(b.maturityDate);
                                    } else {
                                      return a.maturityDate
                                          .compareTo(b.maturityDate);
                                    }
                                  },
                                );
                              }
                              if (newValue == fields[5]) {
                                tasks.sort(
                                  (a, b) {
                                    if (a.maturityDate != b.maturityDate) {
                                      return b.maturityDate
                                          .compareTo(a.maturityDate);
                                    } else {
                                      return b.maturityDate
                                          .compareTo(a.maturityDate);
                                    }
                                  },
                                );
                              }
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
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ));
                          }).toList(),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListOfTasks(
              listDescription: widget.taskList.description,
            )),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => EditListPage(
                                    taskList: taskList,
                                  ))));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(1),
                      backgroundColor: AppColors.myAbbrechenColor,
                      surfaceTintColor: AppColors.myAbbrechenColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      fixedSize: Size(70.0, 70.0),
                    ),
                    child: const Center(
                      child: Stack(children: [
                        Icon(
                          Icons.format_list_bulleted,
                          size: 35,
                          color: Colors.white,
                        ),
                        Positioned(
                            top: 14,
                            right: -5,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                      ]),
                    )),
                const SizedBox(
                  width: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    _database.getAvailableListForUser().then((lists) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CreateToDo(
                                  listCreatedFrom: taskList.description,
                                  availableLists: lists))));
                    });
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.myCheckItGreen,
                    surfaceTintColor: AppColors.myCheckItGreen,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    fixedSize: Size(250.0, 70.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35,
                      ),
                      const SizedBox(height: 3.0),
                      Text(
                        'ToDo erstellen',
                        style: standardTextDecoration.copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/createList');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(1),
                    backgroundColor: AppColors.myDeleteColor,
                    surfaceTintColor: AppColors.myDeleteColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    fixedSize: Size(70.0, 70.0),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _database.getAvailableListForUser().then((lists){
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: ((context) => CreateToDo(listCreatedFrom: taskList.description, availableLists: lists))));
            //     });
            //     setState(() {});
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.myCheckITDarkGrey,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12.0),
            //     ),
            //     fixedSize: const Size(465.0, 20.0),
            //   ),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.add,
            //         color: AppColors.myCheckItGreen,
            //       ),
            //       const SizedBox(width: 8.0),
            //       Text(
            //         'ToDo erstellen',
            //         style: standardTextDecoration,
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
