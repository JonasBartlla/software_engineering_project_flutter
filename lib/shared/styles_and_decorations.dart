import 'package:flutter/material.dart';

var buttonStyleDecoration = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )
  ),
  backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0xFF616161)),
  elevation: MaterialStateProperty.all(8),
  shadowColor: MaterialStateProperty.all(const Color(0xFF212121))
);

var buttonStyleDecorationcolorchange = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )
  ),
  backgroundColor: MaterialStateProperty.resolveWith<Color>(
    (Set<MaterialState> states) {
    if(states.contains(MaterialState.pressed)){
      return Colors.grey;
    } else{
      return const Color.fromRGBO(101, 167, 101, 1);
    }
  }),
  enableFeedback: false,
  elevation: MaterialStateProperty.all(8),
  shadowColor: MaterialStateProperty.all(const Color(0xFF212121))
);

var textInputDecoration = InputDecoration(
                  fillColor: Colors.grey[700],
                  filled: true,
                  hoverColor: Colors.white,
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(159, 214, 214, 214),
                    fontFamily: 'Comfortaa',                   
                  )
                );

var textInputDecorationbez = const InputDecoration(
                  fillColor: Color.fromRGBO(63, 63, 63, 1),
                  filled: false,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,
                    width: 3
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                   ),
                  hoverColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(159, 214, 214, 214) ,
                    fontFamily: 'Comfortaa'                   
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