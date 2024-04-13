import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/edit_task_screen.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final bool done;
  final String listDescription;
  final List<TaskList> lists;

  const TaskTile(
      {required this.task,
      required this.done,
      required this.listDescription,
      required this.lists,
      super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {

  final player = AudioPlayer();

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.isBefore(now) ||
        date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    TaskList? taskListElement;
    if (widget.task.list != "keine Liste") {
      taskListElement = widget.lists
          .where((taskList) => taskList.description == widget.task.list)
          .first;
    }

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
                _database.getAvailableListForUser().then((lists) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => EditTodo(
                              task: widget.task, availableLists: lists))));
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
                      strokeAlign: BorderSide.strokeAlignCenter),
                  checkColor: AppColors.myCheckItGreen,
                  activeColor: AppColors.myCheckItGreen,
                  onChanged: (bool? isChecked) {
                    //ändern des Status zum Abhaken
                    setState(() {                      
                      _database.editTask(
                          widget.task.description,
                          widget.task.note,
                          widget.task.creationDate,
                          widget.task.maturityDate,
                          widget.task.priority,
                          widget.task.list,
                          !widget.task.done,
                          widget.task.ownerId,
                          widget.task.taskReference);
                      widget.task.done = !widget.task.done;
                    });
                    //Checken ob Task abhakt wird und spielt dann Sound
                    if (isChecked == true){
                      playSound();
                    }
                  },
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(widget.task.description),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Wrap(runSpacing: 5, children: [
                  //Liste
                  widget.listDescription == "Mein Tag" ||
                          widget.listDescription == "Alle ToDos" ||
                          widget.listDescription == "Erledigte ToDos"
                      ? widget.task.list == "keine Liste"
                          ? const Text('')
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  taskListElement!.icon,
                                  color: widget.done == false
                                      ? taskListElement!.iconColor
                                      : Colors.grey,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(widget.task.list),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )
                      : const Text(''),

                  //Priorität
                  _database.getPriority(widget.task.priority) ==
                          'keine Priorität'
                      ? const Text('')
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_upward_rounded,
                                color: widget.task.done
                                    ? Colors.grey
                                    : AppColors.myTextColor),
                            const SizedBox(width: 3,),
                            Text(_database.getPriority(widget.task.priority),
                                style: TextStyle(
                                  color: widget.task.done
                                      ? Colors.grey
                                      : AppColors.myTextColor,
                                  decoration: widget.task.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),

                  //Datum und Uhrzeit
                  widget.task.maturityDate ==
                          DateTime.fromMillisecondsSinceEpoch(0)
                      ? const Text('')
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: widget.task.done
                                  ? Colors.grey
                                  : isToday(widget.task.maturityDate)
                                      ? AppColors.myDeleteColor
                                      : AppColors.myTextColor,
                            ),
                            const SizedBox(width: 3,),
                            Text(
                              '${DateFormat('dd.MM.yyyy').format(widget.task.maturityDate)}, ${widget.task.maturityDate.hour.toString().padLeft(2, '0')}:${widget.task.maturityDate.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: widget.task.done
                                    ? Colors.grey
                                    : isToday(widget.task.maturityDate)
                                        ? AppColors.myDeleteColor
                                        : AppColors.myTextColor,
                                decoration: widget.task.done
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),

                  //Notiz
                  widget.task.note == ''
                      ? const Text('')
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.sticky_note_2_rounded,
                              color: widget.task.done
                                  ? Colors.grey
                                  : AppColors.myTextColor,
                            ),
                            const SizedBox(width: 3,),
                            Text('Notiz',
                                style: TextStyle(
                                  color: widget.task.done
                                      ? Colors.grey
                                      : AppColors.myTextColor,
                                  decoration: widget.task.done
                                      ? TextDecoration.lineThrough
                                      : null,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),                  
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
  //Sound holen der abgespielt wird
  Future<void> playSound() async{
  String audioPath = "ping.mp3";
  await player.play(AssetSource(audioPath));
}
}


