import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';


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
    helpText: 'Datum wählen',
    cancelText: 'Kein Datum hinzufügen',
    confirmText: 'Ok',
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(101, 167, 101, 1),
            onSurface: Colors.white,
            surface: AppColors.myCheckITDarkGrey,
            surfaceTint: AppColors.myCheckITDarkGrey
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

  if (selectedDate == null) return DateTime.fromMillisecondsSinceEpoch(0);

  if (!context.mounted) return selectedDate;

  //TimePicker
  final TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(selectedDate),
    helpText: 'Uhrzeit wählen',
    cancelText: 'Keine Uhrzeit hinzufügen',
    confirmText: 'Ok',
    builder: (BuildContext context, Widget? child){
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(101, 167, 101, 1),
            //primaryContainer: Colors.pink,
            //secondary: Colors.pink,
            //tertiary: Colors.pink,
            surfaceVariant: AppColors.myAbbrechenColor,
            onSurface: Colors.white,
            surface: AppColors.myCheckITDarkGrey,
            surfaceTint: AppColors.myCheckITDarkGrey,
            background: Colors.red,
            //shadow: AppColors.myShadowColor
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