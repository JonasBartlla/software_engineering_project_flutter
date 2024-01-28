import 'package:flutter/material.dart';


Future<DateTime?> showDateTimePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  initialDate ??= DateTime.now();
  firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
  lastDate ??= firstDate.add(const Duration(days: 365 * 200));

  //Date Picker
  final DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(101, 167, 101, 1),
            onSurface: Colors.white,
            surface: Color.fromARGB(255, 68, 68, 68)
          ),
          buttonTheme: const ButtonThemeData(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(101, 167, 101, 1),
            )
          )
        ),
        child: child!,
      );
    },
  );

  if (selectedDate == null) return null;

  if (!context.mounted) return selectedDate;

  //TimePicker
  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDate),
    builder: (BuildContext context, Widget? child){
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(101, 167, 101, 1),
            onSurface: Colors.white,
            surface: Color.fromARGB(255, 68, 68, 68)
          ),
          buttonTheme: const ButtonThemeData(
            colorScheme: ColorScheme.dark(
              primary: Color.fromRGBO(101, 167, 101, 1),
            )
          )
        ),
        child: MediaQuery(data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true), 
                  child: child!
                ),
      );
    }
  );

  return selectedTime == null
      ? selectedDate
      : DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
}