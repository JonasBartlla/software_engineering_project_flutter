import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/toDo/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    final User? user = Provider.of<User?>(context); //Zugriff auf den Wert aus dem Provider https://pub.dev/documentation/provider/latest/provider/Provider/of.html
    print(user);

    if (user == null) {
      return const Authenticate();
    }else {
      return const Home();
    }

  }
}