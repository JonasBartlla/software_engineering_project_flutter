import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
                  fillColor: Color.fromRGBO(63, 63, 63, 1),
                  filled: true,
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(63, 63, 63, 1), width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(101, 167, 101, 1), width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(159, 214, 214, 214)
                  )
                );