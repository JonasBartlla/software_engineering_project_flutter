import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

var buttonBoxDecoration = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    fixedSize: MaterialStateProperty.all(Size(100, 10)),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => AppColors.myBoxColor),
    elevation: MaterialStateProperty.all(8),
    shadowColor: MaterialStateProperty.all(AppColors.myShadowColor));

var buttonStyleDecorationDelete = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    fixedSize: MaterialStateProperty.all(Size(120, 40)),
    surfaceTintColor: MaterialStateProperty.all(AppColors.myDeleteColor),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => AppColors.myDeleteColor),
    elevation: MaterialStateProperty.all(8),
    shadowColor: MaterialStateProperty.all(AppColors.myShadowColor));


var buttonStyleDecoration = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    fixedSize: MaterialStateProperty.all(Size(100, 10)),
    surfaceTintColor: MaterialStateProperty.all(AppColors.myBoxColor),
    overlayColor: MaterialStateProperty.all(AppColors.myBoxColor),
    backgroundColor:
        MaterialStateColor.resolveWith((states) => AppColors.myBoxColor),
    elevation: MaterialStateProperty.all(8),
    shadowColor: MaterialStateProperty.all(AppColors.myShadowColor));

var buttonStyleDecorationcolorchange = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    fixedSize: MaterialStateProperty.all(Size(120, 40)),
    surfaceTintColor: MaterialStateProperty.all(AppColors.myCheckItGreen),
    backgroundColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.grey;
      } else {
        return AppColors.myCheckItGreen;
      }
    }),
    enableFeedback: false,
    elevation: MaterialStateProperty.all(8),
    shadowColor: MaterialStateProperty.all(AppColors.myShadowColor));

var textInputDecoration = InputDecoration(
    focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.myCheckItGreen)),
    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.myBoxColor)),
    fillColor: AppColors.myBoxColor,
    filled: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    hoverColor: AppColors.myHoverColor,
    hintStyle: const TextStyle(
      color: AppColors.myTextInputColor,
      fontFamily: 'Comfortaa',
    ));

var textInputDecorationbez = const InputDecoration(
    fillColor: AppColors.myCheckITDarkGrey,
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

var creditTextDecoration = const TextStyle(
    color: AppColors.myBoxColor,
    fontFamily: 'Comfortaa',
    fontSize: 12,
    letterSpacing: 1,
    fontWeight: FontWeight.normal,
    height: 1);

var WaterMarkDecoration = const TextStyle(
    color: AppColors.myWaterMarkColor,
    fontFamily: 'Comfortaa',
    fontSize: 44,
    letterSpacing: 2,
    fontWeight: FontWeight.normal,
    height: 1);
