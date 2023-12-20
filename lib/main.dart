import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/pages/wrapper.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(CheckIT());
}

class CheckIT extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
