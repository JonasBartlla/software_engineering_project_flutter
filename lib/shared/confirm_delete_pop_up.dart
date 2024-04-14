import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/services/database_service.dart';
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
              Text('Möchtest du die Liste wirklich löschen?\n\nAlle darin enthaltenen ToDos werden gelöscht.', style: standardTextDecoration,),
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

Future <void> showDeleteUserConfirmationDialog(DatabaseService databaseService, User? user, BuildContext context) async {
  return showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Account löschen?", style: standardTextDecoration.copyWith(fontSize: 20 ),),
        backgroundColor: AppColors.myCheckITDarkGrey,
        surfaceTintColor: AppColors.myCheckITDarkGrey,
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Möchtest du deinen Account wirklich löschen?\n\n(Bitte nicht 🥺)', style: standardTextDecoration,),
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
            onPressed: () async{
              showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (context) => const Center(child: SpinKitChasingDots(
                                  color: AppColors.myCheckItGreen,
                                ),));
              await user?.delete();
              await databaseService.cleanUpUser(user!.uid);
              Navigator.of(context).popUntil((route) => route.isFirst);
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
    });
}
