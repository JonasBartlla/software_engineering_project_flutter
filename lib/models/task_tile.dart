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

  bool isToday(DateTime date){
    DateTime now = DateTime.now();
    return date.isBefore(now) || date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: AppColors.myBackgroundColor,
        elevation: 0,
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          children: [
            ListTile(
              hoverColor: AppColors.myBackgroundColor,
              splashColor: AppColors.myBackgroundColor,
              selectedTileColor: AppColors.myBackgroundColor,
              titleTextStyle: TextStyle(
                color: widget.task.done ? Colors.grey : AppColors.myTextColor,
                fontSize: 17,
                decoration:
                    widget.task.done ? TextDecoration.lineThrough : null,
              ),
              subtitleTextStyle: TextStyle(
                color: widget.task.done ? Colors.grey : AppColors.myTextColor,
                decoration:
                    widget.task.done ? TextDecoration.lineThrough : null,
              ),
              tileColor: AppColors.myBackgroundColor,
              onTap: () {
                _database.getAvailableListForUser().then((lists){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => EditTodo(task: widget.task, availableLists: lists))
                    )
                );
                });
              },
              leading: Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: widget.task.done,
                  hoverColor: AppColors.myBackgroundColor,
                  splashRadius: 14,
                  shape: const CircleBorder(),
                  side: const BorderSide(
                    color: AppColors.myTextColor,
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignCenter
                  ),
                  checkColor: AppColors.myCheckItGreen,
                  activeColor: AppColors.myCheckItGreen,
                  //side: const BorderSide(color: Colors.white, width: 2),
                  onChanged: (bool? isChecked) {
                    setState(() {
                      _database.editTask(
                          widget.task.description,
                          widget.task.note,
                          widget.task.creationDate,
                          widget.task.notificationOn,
                          widget.task.maturityDate,
                          widget.task.priority,
                          widget.task.list,
                          !widget.task.done,
                          widget.task.ownerId,
                          widget.task.taskReference);
                      widget.task.done = !widget.task.done;
                    });
                  },
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(widget.task.description),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom:3),
                child: Row(children: [
                  //Priorität
                  _database.getPriority(widget.task.priority) == 'no priority'
                      ? const Text('')
                      : Row(
                          children: [
                            Icon(Icons.arrow_upward,
                                color: widget.task.done
                                    ? Colors.grey
                                    : AppColors.myTextColor),
                            Text(_database.getPriority(widget.task.priority),
                                style: TextStyle(
                                  color: widget.task.done
                                      ? Colors.grey
                                      : AppColors.myTextColor,
                                  decoration: widget.task.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
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
                            Icon(
                              Icons.calendar_month_rounded,
                              color: widget.task.done
                                  ? Colors.grey
                                  : isToday(widget.task.maturityDate) ? AppColors.myDeleteColor: AppColors.myTextColor,
                            ),
                            Text(
                              '${DateFormat('dd.MM.yyyy').format(widget.task.maturityDate)}, ${widget.task.maturityDate.hour.toString().padLeft(2, '0')}:${widget.task.maturityDate.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: widget.task.done
                                    ? Colors.grey
                                    : isToday(widget.task.maturityDate) ? AppColors.myDeleteColor : AppColors.myTextColor,
                                decoration: widget.task.done
                                    ? TextDecoration.lineThrough
                                    : null,
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
                      : Row(
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              color: widget.task.done
                                  ? Colors.grey
                                  : AppColors.myTextColor,
                            ),
                            Text('Notiz',
                                style: TextStyle(
                                  color: widget.task.done
                                      ? Colors.grey
                                      : AppColors.myTextColor,
                                  decoration: widget.task.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
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
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.myCheckItGreen,
              ),
            ),
            const Divider(
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
