import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/edit_task_screen.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

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
        color: const Color.fromRGBO(40, 40, 40, 1),
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          children: [
            !widget.task.done //überprüfen, ob Widget fertig ist
                ? ListTile(
                    hoverColor: const Color.fromRGBO(40, 40, 40, 1),
                    titleTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 17),
                    subtitleTextStyle: const TextStyle(color: Colors.white),
                    tileColor: const Color.fromRGBO(40, 40, 40, 1),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  EditTodo(task: widget.task))));
                    },
                    leading: Checkbox(
                      value: widget.task.done,
                      shape: const CircleBorder(),
                      checkColor: const Color.fromRGBO(101, 167, 101, 1),
                      activeColor: const Color.fromRGBO(101, 167, 101, 1),
                      side: const BorderSide(color: Colors.white),
                      onChanged: (bool? isChecked) {
                        setState(() {
                            _database.editTask(
                                widget.task.description,
                                widget.task.note,
                                widget.task.maturityDate,
                                widget.task.notificationOn,
                                widget.task.priority,
                                widget.task.list,
                                !widget.task.done,
                                widget.task.taskReference);
                            widget.task.done = !widget.task.done;
                          // } else {
                          //   _database.editTask(
                          //       widget.task.description,
                          //       widget.task.note,
                          //       widget.task.maturityDate,
                          //       widget.task.notificationOn,
                          //       widget.task.priority,
                          //       widget.task.list,
                          //       true,
                          //       widget.task.taskReference);
                          //   widget.task.done = true;
                        });
                      },
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(widget.task.description),
                    ),
                    subtitle: Row(children: [
                      //Priorität
                      widget.task.priority == 'no priority'
                          ? const Text('')
                          : Row(
                              children: [
                                const Icon(Icons.arrow_upward,
                                    color: AppColors.myTextColor),
                                Text(widget.task.priority,
                                    style: const TextStyle(
                                        color: AppColors.myTextColor)),
                              ],
                            ),

                      const SizedBox(
                        width: 5,
                      ),

                      //Datum und Uhrzeit
                      widget.task.maturityDate ==
                              DateTime.fromMillisecondsSinceEpoch(0)
                          ? const Text('')
                          : Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  color: AppColors.myTextColor,
                                ),
                                Text(
                                  '${DateFormat('dd.MM.yyyy').format(widget.task.maturityDate)} ${widget.task.maturityDate.hour.toString().padLeft(2, '0')}:${widget.task.maturityDate.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      color: AppColors.myTextColor),
                                ),
                              ],
                            ),
                      const SizedBox(
                        width: 5,
                      ),

                      //Notiz
                      widget.task.note == ''
                          ? const Text('')
                          : const Row(
                              children: [
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: AppColors.myTextColor,
                                ),
                                Text('Notiz',
                                    style: TextStyle(
                                        color: AppColors.myTextColor)),
                              ],
                            ),

                      //Benachrichtigung
                      widget.task.notificationOn == true
                          ? const Icon(
                              Icons.notifications_on,
                              color: AppColors.myTextColor,
                            )
                          : const Text(''),
                    ]),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.myTextColor,
                    ),
                  )
                : ListTile( //case, wenn ToDo Done ist
                    hoverColor: const Color.fromRGBO(40, 40, 40, 1),
                    titleTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 17),
                    subtitleTextStyle: const TextStyle(color: Colors.white),
                    tileColor: const Color.fromRGBO(40, 40, 40, 1),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  EditTodo(task: widget.task))));
                    },
                    leading: Checkbox(
                      value: widget.task.done,
                      shape: const CircleBorder(),
                      checkColor: const Color.fromRGBO(101, 167, 101, 1),
                      activeColor: const Color.fromRGBO(101, 167, 101, 1),
                      side: const BorderSide(color: Colors.white),
                      onChanged: (bool? isChecked) {
                        setState(() {

                            _database.editTask(
                                widget.task.description,
                                widget.task.note,
                                widget.task.maturityDate,
                                widget.task.notificationOn,
                                widget.task.priority,
                                widget.task.list,
                                !widget.task.done,
                                widget.task.taskReference);
                            widget.task.done = !widget.task.done;
                        });
                      },
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        widget.task.description,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    ),
                    subtitle: Row(children: [
                      //Hier die Optionalen Angaben unter der Bezeichnung (hier am besten mit Row in Row arbeiten)

                      //Priorität
                      widget.task.priority == 'no priority'
                          ? const Text('')
                          : Row(
                              children: [
                                const Icon(Icons.arrow_upward,
                                    color: Colors.grey),
                                Text(widget.task.priority,
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey)),
                              ],
                            ),

                      const SizedBox(
                        width: 5,
                      ),

                      //Datum und Uhrzeit
                      widget.task.maturityDate ==
                              DateTime.fromMillisecondsSinceEpoch(0)
                          ? const Text('')
                          : Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.grey,
                                ),
                                Text(
                                  '${DateFormat('dd.MM.yyyy').format(widget.task.maturityDate)} ${widget.task.maturityDate.hour.toString().padLeft(2, '0')}:${widget.task.maturityDate.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(
                        width: 5,
                      ),

                      //Notiz
                      widget.task.note == ''
                          ? const Text('')
                          : const Row(
                              children: [
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: Colors.grey,
                                ),
                                Text('Notiz',
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey)),
                              ],
                            ),

                      //Benachrichtigung
                      widget.task.notificationOn == true
                          ? const Icon(
                              Icons.notifications_on,
                              color: Colors.grey,
                            )
                          : const Text(''),
                    ]),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.myTextColor,
                    ),
                  ),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
