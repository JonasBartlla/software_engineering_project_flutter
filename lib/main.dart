import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CheckIT'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[500],
        ),
        body: Container(
      decoration: BoxDecoration(
        color: Colors.black,    
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Text('E-Mail Adresse', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Comfortaa',
        fontSize: 14,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),), SizedBox(height : 7),
Container(
        width: 270,
        height: 27,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
      color : Color.fromRGBO(63, 63, 63, 1),
  )
      ),
],
      ),
    ), SizedBox(height : 19),
Container(
      decoration: BoxDecoration(
          
  ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        
        children: <Widget>[Text('Passwort', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Comfortaa',
        fontSize: 14,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),), SizedBox(height : 15),
Container(
        width: 270,
        height: 27,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
      color : Color.fromRGBO(63, 63, 63, 1),
  )
      ),
],
      ),
    ),
],
      ),
    ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text('+'),
          backgroundColor: Colors.deepOrange[500],
      ),
     ),
    );
  }
  
}

