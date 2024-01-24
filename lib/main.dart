import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/authentification/register.dart';
import 'package:software_engineering_project_flutter/pages/toDo/create_todo.dart';
import 'package:software_engineering_project_flutter/pages/toDo/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      //'/signIn': (context) =>  SignIn(),
      //'/registration': (context) => Registration(),
      '/authentication':(context) => const Authenticate(),
      '/createTodo': (context) => const CreateToDo(),
      '/home':(context) => const Home(),
  },
));
} 