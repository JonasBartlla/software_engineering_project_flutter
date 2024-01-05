import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/authentification/register.dart';
import 'package:software_engineering_project_flutter/pages/toDo/create_todo.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/createTodo',
  routes: {
    '/signIn': (context) =>  SignIn(),
    '/registration': (context) => Registration(),
    '/createTodo': (context) => CreateToDo(),
  },
));