import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/edit_list_screen.dart';
import 'package:software_engineering_project_flutter/services/database_service.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/confirm_delete_pop_up.dart';
import 'package:flutter/material.dart';

Widget getDeleteButton(DatabaseService _database, TaskList taskList, context) {
  if (taskList.isEditable) {
    print('true');
    return ElevatedButton(
      onPressed: () async {
        showDeleteListConfirmationDialog(taskList, _database, context);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(1)),
        surfaceTintColor: MaterialStateProperty.all(AppColors.myDeleteColor),
        overlayColor: MaterialStateProperty.all(AppColors.myDeleteColor),
        backgroundColor: MaterialStateProperty.all(AppColors.myDeleteColor),
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
        fixedSize: MaterialStateProperty.all(Size(70, 70)),
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

Widget getEditButton(TaskList taskList, DatabaseService _database, context) {
  if (taskList.isEditable) {
    return ElevatedButton(
        onPressed: () {
          _database
              .getAvailableListForUser(addInitialLists: true)
              .then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => EditListPage(
                          existingLists: value,
                          taskList: taskList,
                        ))));
          });
        },
        style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(1)),
        surfaceTintColor: MaterialStateProperty.all(AppColors.myAbbrechenColor),
        overlayColor: MaterialStateProperty.all(AppColors.myAbbrechenColor),
        backgroundColor: MaterialStateProperty.all(AppColors.myAbbrechenColor),
        elevation: MaterialStateProperty.all(10),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
        fixedSize: MaterialStateProperty.all(Size(70, 70)),
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
  } else {
    return SizedBox(width: 0.0);
  }
}
