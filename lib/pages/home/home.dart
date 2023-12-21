import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/services/auth.dart';

class Home extends StatelessWidget{

final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
    );
  }

}

