import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/authentification/register.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/signIn',
  routes: {
    '/signIn': (context) =>  SignIn(),
    '/registration': (context) => Registration(),
  },
));