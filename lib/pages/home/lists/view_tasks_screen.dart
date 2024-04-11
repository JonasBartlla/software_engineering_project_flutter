import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/list_of_tasks_widget.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/other_functions.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/models/sort_fields.dart';

class ListOfTasksPage extends StatefulWidget {
  final TaskList taskList;
  final List<TaskList> lists;
  const ListOfTasksPage(
      {required this.taskList, required this.lists, super.key});

  @override
  State<ListOfTasksPage> createState() => _ListOfTaskPageState();
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
              CustomContainer(taskList: taskList),
              const SizedBox(
                height: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: ListOfTasks(
                listDescription: widget.taskList.description,
                lists: widget.lists,
              )),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getEditButton(taskList, _database, context),
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
                    style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.all(1)),
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
                            fixedSize: MaterialStateProperty.all(Size(180, 70)),
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
                  getDeleteButton(_database, taskList, context)
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),

    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.taskList,
  });

  final TaskList taskList;

  @override
  Widget build(BuildContext context) {
    final tt = Provider.of<List<TaskList>>(context).where((element) => element.listReference == taskList.listReference);
    if(tt.isEmpty){
      print("hi");
    }else{
      print(tt.first.description);
    }
    return tt.isEmpty ? Loading() : Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
        child: Text(
          tt.first.description,
          style: const TextStyle(
              color: AppColors.myTextColor, fontSize: 25),
        ),
      ),
    );
  }
}
