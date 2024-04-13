import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';
import 'package:software_engineering_project_flutter/pages/home/main_screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';



class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final User? user = Provider.of<User?>(context);
    
    if (user == null) {
      return Authenticate();
    }else {
      DatabaseService _database = DatabaseService(uid: user.uid);
      return StreamProvider<List<appUser>>.value(
        initialData: [],
        value: _database.appUsers,
        child: Home(user: user, database: _database),
      );
    }

  }
}