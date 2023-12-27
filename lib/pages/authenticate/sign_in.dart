import 'dart:io';

import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/services/auth.dart';
import 'package:software_engineering_project_flutter/shared/constants.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';

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
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 51, 40),
        elevation: 0.0,
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) {
                  if (val!.isEmpty){ // return null if valid
                    return "Enter an email";
                  } else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() { // when the value inside the eMail field changes the value of the variable wil be changed 
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) {
                  if (val!.length < 6){
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
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()){ //Checks if all Validations are passed, falls überall null zurück geliefert wird wird true returnt => ist valid
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
                child: Text('Sign in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
              TextButton.icon(
                onPressed: (){
                  widget.toggleView!();
                  //Navigator.pushReplacementNamed(context, routeName)
                }, 
                icon: Icon(Icons.person), 
                label: Text('Sign Up')
              ),
              SizedBox(height: 12.0),
              Text(error,
                style: TextStyle(
                  color: Colors.red, 
                  fontSize: 14.0,
                ),
              )
            ],
          )
          ),


        ),
    );
  }
}