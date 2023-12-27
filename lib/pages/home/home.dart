import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/pages/home/user_list.dart';
import 'package:software_engineering_project_flutter/services/auth.dart';
import 'package:software_engineering_project_flutter/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget{

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context){
    return StreamProvider<List<Task>?>.value(
      value: DatabaseService().users, 
      initialData: null,
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
            )
          ],
        ),
        body: UserList(),
      ),
    );
  }

}

