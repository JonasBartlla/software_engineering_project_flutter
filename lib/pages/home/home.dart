import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/appUser.dart';
import 'package:software_engineering_project_flutter/pages/home/list_list.dart';
import 'package:software_engineering_project_flutter/models/list.dart';
import 'package:software_engineering_project_flutter/services/auth.dart';
import 'package:software_engineering_project_flutter/services/database.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';


class Home extends StatelessWidget{

final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context){

    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    // return StreamProvider<List<appUser>?>.value(
    //   value: DatabaseService().users, 
    //   initialData: null,
      // child: 
      return StreamProvider<List<TaskList>>.value(
        initialData: [],
        value: _database.lists,
        child: Scaffold(
          backgroundColor: Colors.green,
          appBar: AppBar(
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
          body: Column(
            children: [
              TextButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/create');
                },
                child: Text('Erstellen'),
              ),
              ListOfTaskLists(),

            ],
          ),
        ),
      );
  }

}

