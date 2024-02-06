import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/list_of_tasks_widget.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/models/task.dart';

class ListOfTasksPage extends StatefulWidget {
  const ListOfTasksPage({super.key});

  @override
  State<ListOfTasksPage> createState() => _ListOfTaskPageState();
}

class _ListOfTaskPageState extends State<ListOfTasksPage> {
  @override
  Widget build(BuildContext context) {


    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);


    return StreamProvider<List<Task>>.value(
      initialData: [],
      value: _database.tasks,
      child: Scaffold(
        appBar: AppBar(
          title: Text('*Kategorie*'),
        ),
        body: ListOfTasks(),
      ),
    );
  }
}