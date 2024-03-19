import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/list_of_task_lists_widget.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/list_of_tasks_widget.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/navbar.dart';
import 'package:software_engineering_project_flutter/pages/home/main_screens/settings.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService dummyDatabase = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool switchIndicator = false;

  @override
  Widget build(BuildContext context) {

    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    // return StreamProvider<List<Task>>.value(
    //     initialData: [],
    //     value: _database.tasks,
    return MultiProvider(
      providers: [
        StreamProvider<List<Task>>.value(
          initialData: [],
          value: _database.tasks,
        ),
        StreamProvider<List<TaskList>>.value(
            initialData: [], value: _database.lists)
      ],
      child: Scaffold(
        backgroundColor: AppColors.myBackgroundColor,
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu,
                size: 30, color: AppColors.myBackgroundColor),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          backgroundColor: AppColors.myCheckItGreen,
          centerTitle: true,
          title: Text(
            'CheckIT',
            style: standardAppBarTextDecoration,
          ),
          elevation: 0.0,
        ),
        drawer: Drawer(
          elevation: 5,
          shadowColor: AppColors.myShadowColor,
          backgroundColor: AppColors.myCheckITDarkGrey,
          surfaceTintColor: AppColors.myCheckITDarkGrey,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.myCheckItGreen,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.myTextColor,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.myAbbrechenColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Dennis',
                        style: standardTextDecoration),
                      const SizedBox(height: 4),
                      Text(
                        'dennis@test.de',
                        style: standardTextDecoration.copyWith(fontSize: 14))
                    ],
                  )),
              ListTile(
                title: Row(
                  children: [
                    Text('Profil', style: standardTextDecoration),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.person,
                      color: AppColors.myTextColor,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MySettings())));
                },
              ),
              ListTile(
                title: Text('Datenschutz', style: standardTextDecoration),
                onTap: () {},
              ),
              ListTile(
                title: Text('ABGs', style: standardTextDecoration),
                onTap: () {},
              ),
              ListTile(
                title: Text('Impressum', style: standardTextDecoration),
                onTap: () {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Text('Abmelden',
                        style: standardTextDecoration.copyWith(
                            color: AppColors.myDeleteColor)),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.logout,
                      color: AppColors.myDeleteColor,
                    ),
                  ],
                ),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                const Expanded(
                  child: ListOfTaskLists(),
                ),
                const SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/createList');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(1),
                        backgroundColor: AppColors.myAbbrechenColor,
                        surfaceTintColor: AppColors.myAbbrechenColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.0),
                        ),
                        fixedSize: const Size(70.0, 70.0),
                      ),
                      child: const Icon(
                            Icons.format_list_bulleted_add, 
                            color: Colors.white,
                            size: 35,
                          ),
                    ),
                    const SizedBox(width: 25,),
                    ElevatedButton(
                      onPressed: () {
                       _database.getAvailableListForUser().then((lists){
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CreateToDo(listCreatedFrom: null, availableLists: lists))));
                }); // hier Todo erstellen mit Database
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.myCheckItGreen,
                        surfaceTintColor: AppColors.myCheckItGreen,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.0),
                        ),
                        fixedSize: Size(250.0, 70.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 35,
                          ),
                          const SizedBox(
                              height:
                                  3.0),
                          Text(
                            'ToDo erstellen',
                            style: standardTextDecoration.copyWith(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 25,),
                    ElevatedButton(
                      onPressed: () {
                        //hier gehts zum Kalender
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1),
                        backgroundColor: AppColors.myAbbrechenColor,
                        surfaceTintColor: AppColors.myAbbrechenColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12.0),
                        ),
                        fixedSize: Size(70.0, 70.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Icon(
                            Icons.calendar_month_outlined, 
                            color: Colors.white,
                            size: 35,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                //MyBottomNavigationBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
