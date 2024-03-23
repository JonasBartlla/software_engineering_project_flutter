import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/sort_fields.dart';
import 'package:software_engineering_project_flutter/models/task.dart';

 List<SortFields> fields = [
    SortFields("Erstellungsdatum", Icons.arrow_upward_sharp),
    SortFields("Erstellungsdatum", Icons.arrow_downward_sharp),
    SortFields("Priorität", Icons.arrow_upward_sharp),
    SortFields("Priorität", Icons.arrow_downward_sharp),
    SortFields("Fälligkeit", Icons.arrow_upward_sharp),
    SortFields("Fälligkeit", Icons.arrow_downward_sharp)
  ];

List<Task> sortTasks(List<Task> tasks, SortFields field){
  if (field == fields[0]) {
      tasks.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } else if (field == fields[1]) {
      tasks.sort((a, b) => a.creationDate.compareTo(b.creationDate));
    } else if (field == fields[2]) {
      tasks.sort((a, b) => b.priority.compareTo(a.priority));
    } else if (field == fields[3]) {
      tasks.sort((a, b) => a.priority.compareTo(b.priority));
    } else if (field == fields[4]) {
      tasks.sort((a, b) => a.maturityDate.compareTo(b.maturityDate));
    } else if (field == fields[5]) {
      tasks.sort((a, b) => b.maturityDate.compareTo(a.maturityDate));
    }
  tasks.sort((a, b) => a.done ? 1 : -1);
  return tasks;
}