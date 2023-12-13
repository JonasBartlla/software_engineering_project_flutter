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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CheckIT'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[500],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Container(
            //   height: 100,
            //   child: Text("Here could be a side menu"),
            // ),
            Expanded(
              flex: 1,
              child: Column(   
                mainAxisAlignment: MainAxisAlignment.start,   
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  Container(
                    color: Colors.green,
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text('first Entry',                      
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.yellow,
                      child: Text('second Entry',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.red,
                      child: Text('third Entry',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Text('+'),
          backgroundColor: Colors.deepOrange[500],
        )
    );
  }
}


