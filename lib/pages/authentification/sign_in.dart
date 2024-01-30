import 'dart:io';

import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/shared/constants.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/textfields.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key,this.toggleView});

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) { // if loading is true show loading screen, else shown sign in page
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  //logo
                  const Text('CheckIT', textAlign: TextAlign.left, style: TextStyle(
                    color: Color.fromRGBO(101, 167, 101, 1),
                    fontFamily: 'Comfortaa',
                    fontSize: 70,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1
                  ),),
                  const SizedBox(height: 1),
              
                  const Text('ORGANIZE YOUR DAY', textAlign: TextAlign.left, style: TextStyle(
                    color: Color.fromRGBO(101, 167, 101, 1),
                    fontFamily: 'Comfortaa',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1
                  ),),
              
                  const SizedBox(height: 60),
              
                  //willkommen
                  const Text('Willkommen! ', textAlign: TextAlign.center, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Comfortaa',
                    fontSize: 40,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1
                  ),),
              
                  const SizedBox(height: 70),
              
                  //Email Adresse
                  const Text('E-Mail Adresse', textAlign: TextAlign.left, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Comfortaa',
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    height: 1
                  ),),
                  const SizedBox(height: 2),
                  
                  SizedBox(
                    height: 50.0,
                    width: 700.0,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) {
                      if (val!.isEmpty){ // return null if valid
                        return "Bitte eine E-Mail eingeben";
                      } else{
                        return null;
                      }
                      },
                      onChanged: (val){
                        setState(() { // when the value inside the eMail field changes the value of the variable wil be changed 
                          email = val;
                        }
                        );
                      },
                    ),
                  ),
              
                  const SizedBox(height: 20),
              
                  //Passwort eingabe
                  const Text('Passwort', textAlign: TextAlign.left, style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Comfortaa',
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.normal,
                    height: 1
                  ),),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: 50.0,
                    width: 700.0,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) {
                        if (val!.length < 6 || val.isEmpty){
                          return "Geben sie ein passwort mit mindestens 6 Zeichen an";
                        } else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        password = val; // same for password
                      },
                      obscureText: true,
                    ),
                  ), 
                  const SizedBox(height: 15.0),               
                  //log in Button
                  TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){ //Checks if all Validations are passed, falls überall null zurück geliefert wird wird true returnt => ist valid
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() {
                            error = 'YOU SHALL NOT PASS';
                            loading = false;
                          });
                        }
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(25),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green.shade400,
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                ),

            
                //Registrierung
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    const Text(
                      'Du hast noch keinen Account?',
                      style: TextStyle(
                        color: Colors.white,
                        ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.toggleView!();
                      },
                      child: const Text(
                        'Hier registrieren',
                        style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        ),
                      )
                    )
                  ]
                ),
                const SizedBox(height: 7),           
                //Passwort vergessen
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Passwort vergessen?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(error,
                  style: const TextStyle(
                    color: Colors.red, 
                    fontSize: 14.0,
                  ),
                ),
                ],
              ),
          ),
          ),
        ),
      ),
    );
  }
}