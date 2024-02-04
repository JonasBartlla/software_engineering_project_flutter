import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/pages/home/edit_todo.dart';

class TaskTile extends StatelessWidget {
  
  final Task task;

  const TaskTile({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: ((context) => EditTodo(task: task))));
          },
          leading: Icon(
            Icons.circle_outlined
          ),
          title: Text(task.bezeichnung),
          subtitle: Row(
            children: [
              //Hier die Optionalen Angaben unter der Bezeichnung

              //Priorität
              task.prioritaet == 'no priority' 
              ? const Text('') 
              : const Icon(Icons.arrow_upward),
                Text(task.prioritaet),
              
              //Datum und Uhrzeit
              task.faelligkeitsdatum == DateTime.fromMillisecondsSinceEpoch(0)
              ? const Text('')
              : const Icon(Icons.calendar_month_rounded),
              Text(task.faelligkeitsdatum.toString()),
              const SizedBox(width: 4,),

              //Notiz
              task.notiz == ''
              ? const Text('')
              : const Icon(Icons.list_alt_rounded),

              //Benachrichtigung
              task.benachrichtigung == true
              ? const Icon(Icons.notifications_on)
              : const Text(''),
              
            ]
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}