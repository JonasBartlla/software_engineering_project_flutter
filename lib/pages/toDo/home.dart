import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/pages/toDo/create_todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meine Listen',
          style: standardAppBarTextDecoration,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
        leading: IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.person_outline_rounded),
          iconSize: 35,
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //nur zum Test meiner Variablen
            Text(
                'Chippi Chippi Chappa Chappa',
                style: standardTextDecoration,
            ),
             Text(
              'Homescreen',
              style: standardHeadlineDecoration,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: buttonStyleDecoration,
              icon: const Icon(Icons.add),
              label: const Text('ToDo erstellen'),
              onPressed: (){
                Navigator.pushNamed(context, '/createTodo');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}