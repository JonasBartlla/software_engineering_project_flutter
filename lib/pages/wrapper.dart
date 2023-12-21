import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/pages/authenticate/authenticate.dart';
import 'package:software_engineering_project_flutter/pages/authenticate/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final User? user = Provider.of<User?>(context); //Zugriff auf den Wert aus dem Provider https://pub.dev/documentation/provider/latest/provider/Provider/of.html
    print(user);

    if (user == null) {
      return Authenticate();
    }else {
      return Home();
    }

  }
}