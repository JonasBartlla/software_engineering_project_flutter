import 'package:flutter/material.dart';
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

enum MenuItem { edit, delete }

class SortFields{
  String sortCriteria;
  IconData icon;

  SortFields(this.sortCriteria, this.icon);
}

class _ListOfTaskPageState extends State<ListOfTasksPage> {
  @override
  Widget build(BuildContext context) {
    late List<Task> tasks = widget.tasks;
    final List<SortFields> fields = [
      SortFields("Erstellungsdatum", Icons.arrow_upward_sharp),
      SortFields("Erstellungsdatum", Icons.arrow_downward_sharp),
      SortFields("Priorität", Icons.arrow_upward_sharp),
      SortFields("Priorität", Icons.arrow_downward_sharp),
      SortFields("Fälligkeit", Icons.arrow_upward_sharp),
      SortFields("Fälligkeit", Icons.arrow_downward_sharp)
    ];
    SortFields selectedValue = SortFields("Sortieren", Icons.swap_vert);
    // late String list = widget.list;
    // late IconData icon = widget.icon;
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
              color: AppColors.myCheckITDarkGrey,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Icon(
            taskList.icon,
            size: 40,
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                color: AppColors.myCheckITDarkGrey,
                iconSize: 35,
                onSelected: (value) {
                  if (value == MenuItem.edit) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EditListPage(
                                  taskList: taskList,
                                ))));
                  } else if (value == MenuItem.delete) {
                    //Hier Code zum Löschen einer Liste
                  }
                },
                itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: MenuItem.edit,
                        child: Text(
                          'Liste bearbeiten',
                          style: TextStyle(color: AppColors.myTextColor),
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuItem.delete,
                        child: Text(
                          'Liste löschen',
                          style: TextStyle(color: AppColors.myTextColor),
                        ),
                      )
                    ])
          ],
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
                  style: TextStyle(color: AppColors.myTextColor, fontSize: 25),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DropdownButton<SortFields>(
                      hint: Text(selectedValue.sortCriteria, style: TextStyle(color: Colors.white),),
                      //value: selectedValue,
                      onChanged: (SortFields? newValue){
                        setState(() {
                        if(newValue == fields[0]){
                          tasks.sort((a,b){
                            if(a.creationDate != b.creationDate){
                              return a.creationDate.compareTo(b.creationDate);
                            }
                            else{
                              return a.creationDate.compareTo(b.creationDate);
                            }
                          });
                        }
                      });
                      },
                      items: fields.map((SortFields field){
                        return DropdownMenuItem<SortFields>(
                          value: field,
                          child: Row(
                            children: <Widget>[
                              Icon(field.icon),
                              SizedBox(width: 10,),
                              Text(field.sortCriteria),
                            ],
                          )
                          );
                      }
                      ).toList(),
                    )
                    // TextButton.icon(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.swap_vert,
                    //     color: AppColors.myTextColor,
                    //   ),
                    //   label: const Text(
                    //     'Sortieren',
                    //     style: TextStyle(color: AppColors.myTextColor),
                    //   ),
                    //   style: buttonStyleDecoration,
                    // ),
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
                child: ListOfTasks(
              tasks: tasks,
            )),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                var abc = await Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const CreateToDo())));
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.myCheckITDarkGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                fixedSize: const Size(465.0, 20.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.myCheckItGreen,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'ToDo erstellen',
                    style: standardTextDecoration,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context, MaterialPageRoute(builder: ((context) => CreateToDo())));
        //   },
        //   child: Icon(Icons.add),
        //   backgroundColor: AppColors.myCheckItGreen,
        // ),
      ),
    );
  }
}
