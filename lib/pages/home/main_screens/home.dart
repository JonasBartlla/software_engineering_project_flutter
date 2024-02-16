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
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/navbar.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService dummyDatabase = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final Task task = Task(
        description: 'Test',
        priority: 'Mittel',
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
        backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
          centerTitle: true,
          title: Text(
            'Check IT',
            style: standardAppBarTextDecoration,
          ),
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
              child: TextButton.icon(
                icon: Icon(
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
                SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/createList');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(
                        63, 63, 63, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12.0),
                    ),
                    fixedSize: Size(465.0, 20.0),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add, 
                        color: const Color.fromRGBO(101, 167, 101, 1),
                      ),
                      SizedBox(
                          width:
                              8.0),
                      Text(
                        'Liste Erstellen',
                        style: standardTextDecoration,
                      ),
                    ],
                  ),
                ),
                SizedBox(
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
