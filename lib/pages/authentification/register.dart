import 'package:flutter/material.dart';

import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/textfields.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';

import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/shared/constants.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';


class Register extends StatefulWidget {
  const Register({super.key,this.toggleView});

  final Function? toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state

  String email = '';
  String password = '';
  String password2 = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  //logo
                  Text('CheckIT', 
                    textAlign: TextAlign.left, 
                    style: TextStyle(
                      color: Color.fromRGBO(101, 167, 101, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 70,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                    ),
                  ),
                  const SizedBox(height: 1),
              
                  const Text('ORGANIZE YOUR DAY', 
                    textAlign: TextAlign.left, 
                    style: TextStyle(
                      color: Color.fromRGBO(101, 167, 101, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 16,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                    ),
                  ),
              
                  const SizedBox(height: 60),
              
                  //willkommen
                  const Text('Registrieren! ', 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 40,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                    ),
                  ),
              
                  const SizedBox(height: 70),
              
                  //Email Adresse
                  const Text('E-Mail Adresse', 
                    textAlign: TextAlign.left, 
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 16,
                      letterSpacing: 1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                    ),
                  ),
                  const SizedBox(height: 2),
              
                  SizedBox(
                    height: 50.0,
                    width: 700.0,
                    child: TextFormField(
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
                        }
                        );
                      },
                    ),
                  ),
              
                  const SizedBox(height: 20),
              
                  //Passwort eingabe
                  const Text('Passwort', 
                    textAlign: TextAlign.left, 
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 16,
                      letterSpacing: 1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                    ),
                  ),
                  const SizedBox(height: 2),
              
                  SizedBox(
                    height: 50.0,
                    width: 700.0,
                    child: TextFormField(
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
                  ), 
              
                  const SizedBox(height: 20),
              
                  //Passwort erneut eingeben
                  const Text('Passwort wiederholen', 
                    textAlign: TextAlign.left, 
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Comfortaa',
                      fontSize: 16,
                      letterSpacing: 1 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                   ),
                  ),
                   
                  const SizedBox(height: 2),
              
                  SizedBox(
                    height: 50.0,
                    width: 700.0,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) {
                        if (val!.length < 6){
                          return "Geben sie ein passwort mit mindestens 6 Zeichen an";
                        } else if (val != password){
                          return "Die beiden Passwörter stimmen nicht über ein";
                        }
                        else{
                          return null;
                        }
                      },
                      onChanged: (val){
                        password2 = val; // same for password
                      },
                      obscureText: true,
                    ),
                  ), 
              
                  const SizedBox(height: 25),
              
                  //Registrierung Button
                  TextButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){ //Checks if all Validations are passed, falls überall null zurück geliefert wird wird true returnt => ist valid
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() {
                            error = 'please supply a valid email';
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
                      'Registrieren',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),
              
                const SizedBox(height: 15),
              
                  //hier einloggen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[

                    const Text(
                      'Du hast bereits einen Account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.toggleView!();
                      },
                      child:  const Text(
                        'Hier einloggen',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    )
                  ]
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