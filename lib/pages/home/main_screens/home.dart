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


class Home extends StatelessWidget{

final AuthService _auth = AuthService();
final DatabaseService dummyDatabase = DatabaseService();


  @override
  Widget build(BuildContext context){

    final Task task  = Task(
      description: 'Test', 
      priority: 'Mittel', 
      maturityDate: DateTime(2022, 12, 3, 17, 30), 
      notificationOn: false, 
      ownerId: 'fafdafag', 
      creationDate: DateTime(2022, 12, 3, 17, 30), 
      done: false, 
      taskReference: dummyDatabase.taskCollection.doc('CLXRexhDSJvLB9hntUar'), 
      note: 'lolol');

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
                initialData: [],
                value: _database.lists  
              )
            ],
            child: Scaffold(
              backgroundColor: Colors.grey[850],
              appBar: AppBar(
                backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
                title: Text('Check IT'),
                elevation: 0.0,
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 50.0, 0.0),
                    child: TextButton.icon(
                      icon: Icon(Icons.person,
                        color: Colors.purple,
                      ),
                      label: Text('logout',
                        style: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                      onPressed: () async {
                        await _auth.signOut(); //sorgt dafür dass der Stream den Wert null liefert, somit wird wieder die HomePage angezeigt
                      },
                    ),
                  ),
                  TextButton(
                    style: buttonStyleDecoration,
                    onPressed: (){
                      //_database.deleteTask(_database.taskCollection.doc('hI7a9dF6CVyOphNDPGz8'));
                      _database.addList("test List neu", Icons.abc);
                      DateTime date = DateTime.now();
                      TimeOfDay time = TimeOfDay.now();
                      List<DocumentReference> listReferences = [_database.listCollection.doc('T24M7SyGOrCAxAxJ4hyj')];
                      // _database.addTask("Test Task", "Kacken gehen", date,  time, 'Mittel', listReferences);
                      print('pressed');
                    }, 
                    child: Icon(Icons.add,
                      color: Colors.black,
                    )
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/create');
                      },
                      child: Text('Erstellen'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/createList');
                      },
                      child: Text('Liste Erstellen'),
                    ),
                    TextButton(
                      //bei onpressed dann ggf. die Kategorie mitgeben
                      onPressed: (){
                        Navigator.pushNamed(context, '/view');
                      },
                      child: Text('Tasks anzeigen'),
                      
                    ),
                    ListOfTaskLists(),
                    ListOfTasks(), 
                    TaskTile(task: task)
                  ],
                ),
              ),
            ),
          );
  }

}