import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/models/task.dart';
import 'package:software_engineering_project_flutter/models/task_tile.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/create_list_screen.dart';
import 'package:software_engineering_project_flutter/pages/home/lists/list_of_task_lists_widget.dart';
import 'package:software_engineering_project_flutter/models/task_list.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/pages/home/main_screens/settings.dart';
import 'package:software_engineering_project_flutter/shared/percent_indicator.dart';
import 'package:software_engineering_project_flutter/pages/home/additional_pages/agbs.dart';
import 'package:software_engineering_project_flutter/pages/home/additional_pages/datenschutz.dart';
import 'package:software_engineering_project_flutter/pages/home/additional_pages/impressum.dart';

class Home extends StatefulWidget {
  final User user;
  final DatabaseService database;
  const Home({required this.user, required this.database, super.key});
  @override
  State<Home> createState() => _HomeState();
}

Future<void> _getToken(DatabaseService _database, String uid) async {
  // Request permission
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission();
  print(settings.authorizationStatus);
  // Get token
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    int counter = 0;
    while (counter < 5) {
      try {
        String? token = await FirebaseMessaging.instance.getToken(
            vapidKey:
                'BGDIXeyOmhM29_CgNE0FpJSpxL8pC7G97NKbORyuRhiMdygSAaUFpq-AkMu330j3H-HXTsLHDDOePtdV6UVc9l4');
        print(token);
        await _database.updateToken(uid, token);
        print('update done');
        break;
      } catch (e) {
        print(e.toString());
        counter = counter + 1;
      }
    }
  } else {
    _database.updateToken(uid, '');
  }
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  late DatabaseService _database;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late User user;

  @override
  void initState() {
    user = widget.user;
    _database = widget.database;
    _getToken(_database, user.uid);
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children:[
            const Icon(Icons.notifications_active_rounded,
            color: AppColors.myCheckItGreen,
            size: 40,),
            const SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.notification!.title ??'', 
                style: standardTextDecoration,),
                const SizedBox(height: 4,),
                Text(event.notification!.body ??'',
                style: standardTextDecoration.copyWith(
                  fontSize: 14
                ),),
              ],
            ),
          ]
            ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ));}
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    final List<appUser> currenUser = Provider.of<List<appUser>>(context);

    if (currenUser.isEmpty) {
      return Loading();
    } else {
      return MultiProvider(
        providers: [
          StreamProvider<List<Task>>.value(
            initialData: [],
            value: _database.tasks,
          ),
          StreamProvider<List<TaskList>>.value(
              initialData: [], value: _database.lists),
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
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(currenUser.first.imageUrl),
                        ),
                        // Container(
                        //   height: 75,
                        //   width: 75,
                        //   decoration: const BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: AppColors.myTextColor,
                        //   ),
                        //   child: const Icon(
                        //     Icons.person,
                        //     size: 50,
                        //     color: AppColors.myAbbrechenColor,
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        Text(currenUser.first.displayName,
                            style: standardTextDecoration),
                        const SizedBox(height: 4),
                        Text(currenUser.first.email,
                            style:
                                standardTextDecoration.copyWith(fontSize: 14))
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MySettings(
                                currentUser: currenUser.first,
                                databaseService: _database))));
                  },
                ),
                ListTile(
                  title: Text('Datenschutz', style: standardTextDecoration),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Datenschutz())));
                  },
                ),
                ListTile(
                  title: Text('AGBs', style: standardTextDecoration),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Agbs())));
                  },
                ),
                ListTile(
                  title: Text('Impressum', style: standardTextDecoration),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Impressum())));
                  },
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
                    await _auth.signOut(user!.uid);
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(
                    child: ListOfTaskLists(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await _database
                              .getAvailableListForUser(addInitialLists: true)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        CreateListPage(existingLists: value))));
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(1)),
                          surfaceTintColor: MaterialStateProperty.all(
                              AppColors.myAbbrechenColor),
                          overlayColor: MaterialStateProperty.all(
                              AppColors.myAbbrechenColor),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.myAbbrechenColor),
                          elevation: MaterialStateProperty.all(10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                          fixedSize: MaterialStateProperty.all(Size(70, 70)),
                        ),
                        child: const Icon(
                          Icons.format_list_bulleted_add,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _database.getAvailableListForUser().then((lists) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => CreateToDo(
                                        listCreatedFrom: 'keine Liste',
                                        availableLists: lists))));
                          }); // hier Todo erstellen mit Database
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(1)),
                          surfaceTintColor: MaterialStateProperty.all(
                              AppColors.myCheckItGreen),
                          overlayColor: MaterialStateProperty.all(
                              AppColors.myCheckItGreen),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.myCheckItGreen),
                          elevation: MaterialStateProperty.all(10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                          fixedSize: MaterialStateProperty.all(Size(180, 70)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 35,
                            ),
                            const SizedBox(height: 3.0),
                            Text(
                              'ToDo erstellen',
                              style:
                                  standardTextDecoration.copyWith(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //hier gehts zum Kalender
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.all(1)),
                          surfaceTintColor: MaterialStateProperty.all(
                              AppColors.myAbbrechenColor),
                          overlayColor: MaterialStateProperty.all(
                              AppColors.myAbbrechenColor),
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.myAbbrechenColor),
                          elevation: MaterialStateProperty.all(10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                          fixedSize: MaterialStateProperty.all(Size(70, 70)),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
