import 'package:flutter/material.dart';

class Home extends StatelessWidget{

  late String username;
  late String pass;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckIT'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextFormField(
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true,
            ),
          ]
        ),
      ),
    );
  }
}