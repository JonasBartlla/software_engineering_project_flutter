import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/textfields_borderless.dart';


class CreateTodo extends StatelessWidget {
  CreateTodo({super.key});

  //contoller
  final descController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900],

      //Appbar 
      appBar: AppBar(
        leading:  IconButton(
            onPressed: () {       
            },
            icon: Icon(
              Icons.person_2_outlined,
              color: Colors.grey[700],
              size: 35.0,
            ),
          ),
        backgroundColor: Colors.green[400],
        title: const Text('To Do anlegen'),
        centerTitle: true,
        elevation: 0,
      ),

      //Body 
      body: SafeArea(

        //Großer Container
        child: Container(
      width: 500,
      height: 700,
      
      //Grauer Kasten
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 70,
        left: 35,
        child: Container(
          width: 324,
        height: 450,
        decoration: const BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
      color : Color.fromRGBO(63, 63, 63, 1),
  ),

      //Spalte zur Anordnung
  child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,

    children: <Widget>[

      //Icon in der Ecke
      const Icon(Icons.add, color: Colors.white, size: 30.0,),
      const SizedBox(height: 10),

      //Description Textfield
      MyTextFields(
        controller: descController,
        hintText: 'Bezeichnung',
        obscureText: false,
        ),
      
      const SizedBox(height: 5),

      //Note Textfield
      MyTextFields(
        controller: noteController, 
        hintText: 'Notiz',
        obscureText: false,
        ),
      
      const SizedBox(height: 30),

      //Text und Drop down Liste (Kommt noch)
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Text('zugehörige Liste',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 30),

      //Text und Drop down Prio (Kommt noch)
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Text('Priorität',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 30),


      //text und Drop down Wiederholung (Kommt noch)
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Text('Wiederholung',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
        ),
      ),
    ],
  ),
      ),
      ),
        ],
      ),
    ),
      ),
    );
  }
}