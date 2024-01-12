import 'package:flutter/material.dart';

var buttonStyleDecoration = ButtonStyle(
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
    if(states.contains(MaterialState.pressed)){
      return Colors.grey;
    } else{
      return const Color.fromRGBO(101, 167, 101, 1);
    }
  }),
  enableFeedback: false,
  
);