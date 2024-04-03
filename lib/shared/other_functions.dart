import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/edit_list_screen.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:flutter/material.dart';                        
                            
Widget getDeleteButton(DatabaseService _database, TaskList taskList, context){
  if (taskList.isEditable){
    print('true');
    return ElevatedButton(
      onPressed: () async {
        _database.deleteList(taskList.listReference, taskList.description);
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(1),
        backgroundColor: AppColors.myDeleteColor,
        surfaceTintColor: AppColors.myDeleteColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        fixedSize: Size(70.0, 70.0),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  } else {
    print('false');
    return SizedBox(width: 0);
  }
}

Widget getEditButton(TaskList taskList, DatabaseService _database, context){
  if (taskList.isEditable){
    return  ElevatedButton(
      onPressed: () {
        _database.getAvailableListForUser(addInitialLists: true).then((value){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => EditListPage(
                    existingLists: value,
                    taskList: taskList,
                    ))));
        }
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(1),
        backgroundColor: AppColors.myAbbrechenColor,
        surfaceTintColor: AppColors.myAbbrechenColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        fixedSize: Size(70.0, 70.0),
      ),
      child: const Center(
        child: Stack(children: [
          Icon(
            Icons.format_list_bulleted,
            size: 35,
            color: Colors.white,
          ),
          Positioned(
              top: 14,
              right: -5,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ]),
      ));
  }else{
    return SizedBox(width: 0.0);
  }
}        
                            