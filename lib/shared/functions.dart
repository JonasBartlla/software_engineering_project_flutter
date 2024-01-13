import 'package:flutter/material.dart';

Future <DateTime?> selectDate(BuildContext context, DateTime? selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate!,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) {
    return picked;
  } else{
      return selectedDate;
  }
}