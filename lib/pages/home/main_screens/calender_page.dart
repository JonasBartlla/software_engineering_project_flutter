import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return MultiProvider(
      providers: [
        StreamProvider<List<Task>>.value(
          value: _database.tasks,
          initialData: [],
        ),
        StreamProvider<List<TaskList>>.value(
          value: _database.lists,
          initialData: [],
        ),
      ],
      child: StreamProvider<List<Task>>.value(
        value: _database.tasks,
        initialData: [],
        child: Scaffold(
          backgroundColor: AppColors.myBackgroundColor,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.myBackgroundColor,
                size: 35,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'Kalender',
              style: standardAppBarTextDecoration,
            ),
            backgroundColor: AppColors.myCheckItGreen,
          ),
          body: const SafeArea(
            child: customValueListBuilder(),
          ),
        ),
      ),
    );
  }
}

class customValueListBuilder extends StatefulWidget {
  const customValueListBuilder({
    super.key,
  });

  @override
  State<customValueListBuilder> createState() => _customValueListBuilderState();
}

class _customValueListBuilderState extends State<customValueListBuilder> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = Provider.of<List<Task>>(context).where((element) {
      if (element.maturityDate.isAfter(DateTime(_selectedDay.year,
              _selectedDay.month, _selectedDay.day - 1, 23, 59)) &&
          element.maturityDate.isBefore(DateTime(
              _selectedDay.year, _selectedDay.month, _selectedDay.day + 1))) {
        return true;
      } else {
        return false;
      }
    }).toList();

    final List<TaskList> lists = Provider.of<List<TaskList>>(context);
    final List<Task> forTasksMap = Provider.of<List<Task>>(context);

    Map<DateTime, List<Task>> taskEvents = {};
    forTasksMap.forEach((task) {
      DateTime taskDateTime = task.maturityDate;
      if (!taskEvents.containsKey(taskDateTime)) {
        taskEvents[taskDateTime] = [];
      }
      taskEvents[taskDateTime]!.add(task);
    });

    taskEvents.forEach((dateTime, taskList) {      
      taskList.forEach((task) {
      });
    });

    
    List<Task> getEventsForDay(DateTime day) {
      return taskEvents[day] ?? [];
    }
    //

    return Column(
      children: [
        TableCalendar(
          eventLoader: (day) => getEventsForDay(day),
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          availableCalendarFormats: const {CalendarFormat.month : 'Monat', CalendarFormat.twoWeeks : '2 Wochen', CalendarFormat.week : 'Woche'},
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: 'de',
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
              defaultTextStyle: standardTextDecoration,
              weekendTextStyle: standardTextDecoration,
              outsideTextStyle:
                  standardTextDecoration.copyWith(color: Colors.grey),
              selectedDecoration: const BoxDecoration(
                  color: AppColors.myCheckItGreen, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(width: 2, color: AppColors.myCheckItGreen))),
          headerStyle: HeaderStyle(
            formatButtonVisible: true,
            //titleCentered: true,
            formatButtonDecoration: const BoxDecoration(
                border: Border.fromBorderSide(
                    BorderSide(color: AppColors.myTextColor)),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            formatButtonTextStyle: standardTextDecoration,
            titleTextStyle: standardTextDecoration,
            formatButtonShowsNext: false,
            leftChevronIcon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.myTextColor,
            ),
            rightChevronIcon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.myTextColor,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: standardTextDecoration,
              weekendStyle: standardTextDecoration),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.myCheckItGreen,
                thickness: 3.0,
                indent: 20,
                endIndent: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Anstehende ToDos',
                style: standardTextDecoration.copyWith(
                    color: AppColors.myCheckItGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            const Expanded(
              child: Divider(
                color: AppColors.myCheckItGreen,
                thickness: 3.0,
                indent: 10,
                endIndent: 20,
              ),
            ),
          ],
        ),
                const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: tasks[index],
                  done: tasks[index].done,
                  listDescription: "Alle ToDos",
                  lists: lists,
                );
              }),
        ),
      ],
    );
  }
}
