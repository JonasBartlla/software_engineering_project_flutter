import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

var buttonStyleDecoration = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => AppColors.myAbbrechenColor),
    elevation: MaterialStateProperty.all(8),
    shadowColor: MaterialStateProperty.all(AppColors.myShadowColor));

var buttonStyleDecorationcolorchange = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    backgroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.grey;
      } else {
        return AppColors.myGreenButton;
      }
    }),
    enableFeedback: false,
    elevation: MaterialStateProperty.all(8),
    shadowColor: MaterialStateProperty.all(AppColors.myShadowColor));

var textInputDecoration = InputDecoration(
    fillColor: AppColors.myFillingColor,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    hoverColor: AppColors.myHoverColor,
    hintStyle: const TextStyle(
      color: AppColors.myTextInputColor,
      fontFamily: 'Comfortaa',
    ));

var textInputDecorationbez = const InputDecoration(
    fillColor: AppColors.myFillingColor,
    filled: false,
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 3)),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    hoverColor: AppColors.myHoverColor,
    hintStyle: TextStyle(
        color: AppColors.myTextInputColor, fontFamily: 'Comfortaa'));

var standardTextDecoration = const TextStyle(
    color: AppColors.myTextColor,
    fontFamily: 'Comfortaa',
    fontSize: 16,
    letterSpacing: 1,
    fontWeight: FontWeight.normal,
    height: 1);

var standardHeadlineDecoration = const TextStyle(
    color: AppColors.myTextColor,
    fontFamily: 'Comfortaa',
    fontSize: 20,
    letterSpacing: 1,
    fontWeight: FontWeight.bold,
    height: 1);

var standardAppBarTextDecoration = const TextStyle(
    color: AppColors.myTextColor,
    fontFamily: 'Comfortaa',
    fontSize: 30,
    letterSpacing: 1,
    fontWeight: FontWeight.bold,
    height: 1);

