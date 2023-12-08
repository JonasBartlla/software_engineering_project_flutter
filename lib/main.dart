import 'dart:developer';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MaterialApp(
  home: Home(),

  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CheckIT'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[500],
        ),
        body: Center(
          // child: Text('Welcome to the homepage',
          //   style: TextStyle(
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.deepOrange,
          //     fontFamily: 'RubikBubbles',
          //   ),
          // child: Image(
          //   image: AssetImage('assets/todo.jpg'),
          //   fit: BoxFit.fill,
          // ),
          child: ElevatedButton.icon(
            onPressed: () {
              log('Yes sir');
            },
            icon: const Icon(Icons.plus_one),
            label: const Text('Add a new list'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.amber;
                  }else if (states.contains(MaterialState.hovered)){
                    return Colors.cyan;
                  }
                  return null; // Use the component's default.
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text('+'),
          backgroundColor: Colors.deepOrange[500],
      ),
    );
  }
}

