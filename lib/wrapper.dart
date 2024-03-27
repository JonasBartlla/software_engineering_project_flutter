import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/home/main_screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';



class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final User? user = Provider.of<User?>(context); //Zugriff auf den Wert aus dem Provider https://pub.dev/documentation/provider/latest/provider/Provider/of.html
    print(user);
    
    if (user == null) {
      return Authenticate();
    }else {
      DatabaseService _database = DatabaseService(uid: user.uid);
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings;
      messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true 
        ).then((value)async{
          settings = value;
          print(settings.authorizationStatus);
          final token =  await messaging.getToken(vapidKey: 'BGDIXeyOmhM29_CgNE0FpJSpxL8pC7G97NKbORyuRhiMdygSAaUFpq-AkMu330j3H-HXTsLHDDOePtdV6UVc9l4');
          print(token);

        });
      return StreamProvider<List<appUser>>.value(
        initialData: [],
        value: _database.appUsers,
        child: Home(),
      );
    }

  }
}