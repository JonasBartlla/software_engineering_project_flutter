import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';

class EditListPage extends StatefulWidget {

  final TaskList taskList;
  const EditListPage({required this.taskList, super.key});

  @override
  State<EditListPage> createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  
  late TaskList taskList = widget.taskList;
  final _formKey = GlobalKey<FormState>();

  //Felder einer Liste
  late String title = taskList.description;
  late IconData icon = taskList.icon;

  //Liste für die auswählbaren Icons
  List<IconData> choosableIcons = [
    Icons.abc,
    Icons.house,
    Icons.calendar_month_rounded
  ];
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}