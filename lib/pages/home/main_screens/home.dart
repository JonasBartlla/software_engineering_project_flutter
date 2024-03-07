import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/list_of_task_lists_widget.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/list_of_tasks_widget.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/navbar.dart';
import 'package:software_engineering_project_flutter/pages/home/main_screens/settings.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService dummyDatabase = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final Task task = Task(
        description: 'Test',
        priority: 3, //'Mittel',
        maturityDate: DateTime(2022, 12, 3, 17, 30),
        notificationOn: false,
        ownerId: 'fafdafag',
        creationDate: DateTime(2022, 12, 3, 17, 30),
        done: false,
        taskReference: dummyDatabase.taskCollection.doc('CLXRexhDSJvLB9hntUar'),
        note: 'lolol',
        list: 'Haushalt');

    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    // return StreamProvider<List<Task>>.value(
    //     initialData: [],
    //     value: _database.tasks,
    return MultiProvider(
      providers: [
        StreamProvider<List<Task>>.value(
          initialData: [],
          value: _database.tasks,
        ),
        StreamProvider<List<TaskList>>.value(
            initialData: [], value: _database.lists)
      ],
      child: Scaffold(
        backgroundColor: AppColors.myBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.person, 
              size: 30,
              color: AppColors.myBackgroundColor
              ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context)=>MySettings())));
            },
          ),
          backgroundColor: AppColors.myCheckItGreen,
          centerTitle: true,
          title: Text(
            'CheckIT',
            style: standardAppBarTextDecoration,
          ),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: TextButton.icon(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text('logout', style: standardTextDecoration),
                onPressed: () async {
                  await _auth
                      .signOut(); //sorgt dafür dass der Stream den Wert null liefert, somit wird wieder die HomePage angezeigt
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                const Expanded(
                  child: ListOfTaskLists(),
                ),
                const SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/createList');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.myCheckITDarkGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0),
                    ),
                    fixedSize: Size(465.0, 20.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add, 
                        color: AppColors.myCheckItGreen,
                      ),
                      const SizedBox(
                          width:
                              8.0),
                      Text(
                        'Liste Erstellen',
                        style: standardTextDecoration,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                MyBottomNavigationBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
