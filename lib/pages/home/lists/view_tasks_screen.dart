import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/list_of_tasks_widget.dart';
import 'package:software_engineering_project_flutter/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/other_functions.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';

class ListOfTasksPage extends StatefulWidget {
  final TaskList taskList;
  final List<TaskList> lists;
  const ListOfTasksPage(
      {required this.taskList, required this.lists, super.key});

  @override
  State<ListOfTasksPage> createState() => _ListOfTaskPageState();
}

class _ListOfTaskPageState extends State<ListOfTasksPage> {

  @override
  Widget build(BuildContext context) {
    late TaskList taskList = widget.taskList;
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return MultiProvider(
      providers: [
        StreamProvider<List<Task>>.value(
        initialData: [],
        value: _database.tasks,
        ),
        StreamProvider<List<TaskList>>.value(
        initialData: [],
        value: _database.lists,
        )
      ],
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
            title: CustomIcon(taskList: taskList),
            centerTitle: true,
          ),
          body: CustomContainer(databaseService: _database, taskList: taskList),
        ),

    );
  }
}

class CustomIcon extends StatefulWidget {
  const CustomIcon({
    super.key,
    required this.taskList,
  });

  final TaskList taskList;

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<List<TaskList>>(context).where((element) => element.listReference == widget.taskList.listReference);
    return taskList.isEmpty ? Loading() : Icon(
      taskList.first.icon,
      color: AppColors.myBackgroundColor,
      size: 40,
    );
  }
}

class CustomContainer extends StatefulWidget {
  const CustomContainer({
    super.key,
    required this.taskList,
    required this.databaseService
  });

  final DatabaseService databaseService;
  final TaskList taskList;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {

  late DatabaseService _database;
  @override
  void initState() {
    _database = widget.databaseService;
  }

  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<List<TaskList>>(context).where((element) => element.listReference == widget.taskList.listReference);
    final allList = Provider.of<List<TaskList>>(context);

    return taskList.isEmpty || allList.isEmpty ? Loading() : Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                  child: Text(
                    taskList.first.description,
                    style: const TextStyle(
                        color: AppColors.myTextColor, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListOfTasks(
                listDescription: taskList.first.description,
                lists: allList,
              )),
              const SizedBox(
                height: 5,
              ),
              //Liste bearbeiten Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getEditButton(taskList.first, _database, context),
                  const SizedBox(
                    width: 25,
                  ),
                  //ToDo erstellen Button
                  ElevatedButton(
                    onPressed: () {
                      _database.getAvailableListForUser().then((lists) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CreateToDo(
                                    listCreatedFrom: taskList.first.description,
                                    availableLists: lists))));
                      });
                      setState(() {});
                    },
                    style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.all(1)),
                            surfaceTintColor: MaterialStateProperty.all(
                                AppColors.myCheckItGreen),
                            overlayColor: MaterialStateProperty.all(
                                AppColors.myCheckItGreen),
                            backgroundColor: MaterialStateProperty.all(AppColors.myCheckItGreen),
                            elevation: MaterialStateProperty.all(10),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                            fixedSize: MaterialStateProperty.all(const Size(180, 70)),
                          ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add_rounded,
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
                  //löschen Button
                  getDeleteButton(_database, taskList.first, context)
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          );
  }
}
