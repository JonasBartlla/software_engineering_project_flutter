import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';


Future<void> showDeleteListConfirmationDialog(TaskList taskList, DatabaseService _database, BuildContext context,) async{
  return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Liste löschen?', style: standardTextDecoration.copyWith(fontSize: 20 ),),
        backgroundColor: AppColors.myCheckITDarkGrey,
        surfaceTintColor: AppColors.myCheckITDarkGrey,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Möchtest du die Liste wirklich löschen? Alle darin enthaltenen ToDos werden gelöscht.', style: standardTextDecoration,),
            ],
          )
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              }, 
            child: const Text('Abbrechen', style: TextStyle(
                                      color: AppColors.myTextColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.normal,
                                      height: 1),)),
          TextButton(
            style: buttonStyleDecorationDelete,
            onPressed: (){
              _database.deleteList(taskList.listReference, taskList.description);
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            }, 
            child: const Text('Löschen', style: TextStyle(
                                      color: AppColors.myTextColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.normal,
                                      height: 1),))
        ],
      );
    },
    );
}

Future<void> showDeleteTaskConfirmationDialog(Task task, DatabaseService _database, BuildContext context,) async{
  return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ToDo löschen?', style: standardTextDecoration.copyWith(fontSize: 20 ),),
        backgroundColor: AppColors.myCheckITDarkGrey,
        surfaceTintColor: AppColors.myCheckITDarkGrey,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Möchtest du das ToDo wirklich löschen?', style: standardTextDecoration,),
            ],
          )
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              }, 
            child: const Text('Abbrechen', style: TextStyle(
                                      color: AppColors.myTextColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.normal,
                                      height: 1),)),
          TextButton(
            style: buttonStyleDecorationDelete,
            onPressed: (){
              _database.deleteTask(task.taskReference);
              // Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pop(context);
              Navigator.pop(context);
            }, 
            child: const Text('Löschen', style: TextStyle(
                                      color: AppColors.myTextColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.normal,
                                      height: 1),))
        ],
      );
    },
    );
}