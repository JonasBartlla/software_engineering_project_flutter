import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/edit_task_screen.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final bool done;

  const TaskTile({required this.task, required this.done, super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => EditTodo(task: widget.task))));
          },
          leading: Checkbox(
            value: widget.task.done,
            shape: const CircleBorder(),
            checkColor: const Color.fromRGBO(101, 167, 101, 1),
            activeColor: const Color.fromRGBO(101, 167, 101, 1),
            onChanged: (bool? isChecked) {
              setState(() {
                if (widget.task.done) {
                  _database.editTask(
                      widget.task.description,
                      widget.task.note,
                      widget.task.maturityDate,
                      widget.task.notificationOn,
                      widget.task.priority,
                      widget.task.list,
                      false,
                      widget.task.taskReference);
                  widget.task.done = false;
                } else {
                  _database.editTask(
                      widget.task.description,
                      widget.task.note,
                      widget.task.maturityDate,
                      widget.task.notificationOn,
                      widget.task.priority,
                      widget.task.list,
                      true,
                      widget.task.taskReference);
                  widget.task.done = true;
                }
              });
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.circle_outlined),
          //   onPressed: (){
          //     if(widget.task.done){
          //       _database.editTask(widget.task.description, widget.task.note, widget.task.maturityDate, widget.task.notificationOn, widget.task.priority, widget.task.list, false, widget.task.taskReference);
          //     } else{
          //       _database.editTask(widget.task.description, widget.task.note, widget.task.maturityDate, widget.task.notificationOn, widget.task.priority, widget.task.list, true, widget.task.taskReference);
          //     }
          //   },
          // ),
          title: Text(widget.task.description),
          subtitle: Row(children: [
            //Hier die Optionalen Angaben unter der Bezeichnung (hier am besten mit Row in Row arbeiten)

            //Priorität
            widget.task.priority == 'no priority'
                ? const Text('')
                : const Icon(Icons.arrow_upward),
            Text(widget.task.priority),

            //Datum und Uhrzeit
            widget.task.maturityDate == DateTime.fromMillisecondsSinceEpoch(0)
                ? const Text('')
                : const Icon(Icons.calendar_month_rounded),
            Text(widget.task.maturityDate.toString()),
            const SizedBox(
              width: 4,
            ),

            //Notiz
            widget.task.note == ''
                ? const Text('')
                : const Icon(Icons.list_alt_rounded),

            //Benachrichtigung
            widget.task.notificationOn == true
                ? const Icon(Icons.notifications_on)
                : const Text(''),
          ]),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
