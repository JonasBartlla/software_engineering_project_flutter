import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/taskList.dart';

class ListTileTest extends StatelessWidget {

  final TaskList taskList;

  const ListTileTest({required this.taskList, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Icon(
            taskList.icon
          ),
          title: Text(taskList.description),
          subtitle: Text("Contains tasks"),
        ),
      )
    );
  }
}