import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/pages/home/create_todo.dart';
import 'package:software_engineering_project_flutter/wrapper.dart';
import 'package:software_engineering_project_flutter/pages/home/home.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(CheckIT());
}

class CheckIT extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamProvider<User?>.value( //The StreamProvider listens to a Stream (in this case a Stream provider Instances of the class User) and exposes its content to child
      initialData: null, //https://pub.dev/documentation/provider/latest/provider/StreamProvider-class.html
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/create':(context) => const CreateToDo()
        },
        //home: Wrapper(),
    
      ),
    );
  }
}


// Class? also eine Klasse mit einem ? dahinter bedeutet, dass diese Variable entweder einen gültiger Wert der Klasse besitzen kann oder das Wert der Variable null sein kann
// ohne das ? wäre null kein gültiger Wert für die Variable