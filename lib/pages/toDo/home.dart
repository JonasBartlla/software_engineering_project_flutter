import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
//import 'package:software_engineering_project_flutter/pages/toDo/create_todo.dart';

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
        title: const Center(child: Text('CheckIt')),
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Homescreen',
              style: TextStyle(color: Colors.white),
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