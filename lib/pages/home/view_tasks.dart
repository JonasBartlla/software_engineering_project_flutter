import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/pages/home/listOfTasks.dart';

class ListOfTasksPage extends StatefulWidget {
  const ListOfTasksPage({super.key});

  @override
  State<ListOfTasksPage> createState() => _ListOfTaskPageState();
}

class _ListOfTaskPageState extends State<ListOfTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('*Kategorie*'),
      ),
      body: ListOfTasks(),
    );
  }
}