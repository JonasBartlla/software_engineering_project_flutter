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

var textInputDecoration = InputDecoration(
                  fillColor: const Color.fromRGBO(63, 63, 63, 1),
                  filled: true,
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromRGBO(63, 63, 63, 1), width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color.fromRGBO(101, 167, 101, 1), width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(159, 214, 214, 214)
                  )
                );

var standardTextDecoration = const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.normal,
                  height: 1
);

var standardHeadlineDecoration = const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  height: 1
);

var standardAppBarTextDecoration = const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Comfortaa',
                  fontSize: 30,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  height: 1
);