import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              startingDayOfWeek: StartingDayOfWeek.monday,
              locale: 'de',
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay){
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
              calendarStyle:  CalendarStyle(
                defaultTextStyle:  standardTextDecoration,
                weekendTextStyle: standardTextDecoration,
                outsideTextStyle: standardTextDecoration.copyWith(color: Colors.grey),
                selectedDecoration: const BoxDecoration(color: AppColors.myCheckItGreen, shape: BoxShape.circle),
                todayDecoration: BoxDecoration( shape: BoxShape.circle, border: Border.all(width: 2, color: AppColors.myCheckItGreen)) 
              ),
              headerStyle:  HeaderStyle(
                formatButtonVisible: false,
                //titleCentered: true,
                formatButtonDecoration: const BoxDecoration(border: Border.fromBorderSide(BorderSide(color: AppColors.myTextColor)), borderRadius: BorderRadius.all(Radius.circular(12.0))),
                formatButtonTextStyle: standardTextDecoration,
                titleTextStyle: standardTextDecoration,
                formatButtonShowsNext: false,
                leftChevronIcon: const Icon(Icons.arrow_back_rounded, color: AppColors.myTextColor,),
                rightChevronIcon: const Icon(Icons.arrow_forward_rounded, color: AppColors.myTextColor,),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: standardTextDecoration,
                weekendStyle: standardTextDecoration
              ),
            ),
            const SizedBox(height: 8,),
            // Expanded(
            //   child: ValueListenableBuilder<List<Task>>(
            //     valueListenable: valueListenable, 
            //     builder: builder
            //     )
            // ),
          ],
        ),
      ),
    );
  }
}