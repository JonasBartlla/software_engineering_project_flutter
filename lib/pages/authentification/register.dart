import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/textfields.dart';
import 'package:software_engineering_project_flutter/pages/authentification/sign_in.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';


class Registration extends StatefulWidget {
  
  final Function toggleView;
  const Registration({super.key, required this.toggleView});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  //controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                const Text('CheckIT', textAlign: TextAlign.left, style: TextStyle(
                  color: Color.fromRGBO(101, 167, 101, 1),
                  fontFamily: 'Comfortaa',
                  fontSize: 70,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1
                ),),
                const SizedBox(height: 1),
            
                const Text('ORGANIZE YOUR DAY', textAlign: TextAlign.left, style: TextStyle(
                  color: Color.fromRGBO(101, 167, 101, 1),
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1
                ),),
            
                const SizedBox(height: 60),
            
                //willkommen
                const Text('Registrieren! ', textAlign: TextAlign.center, style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Comfortaa',
                  fontSize: 40,
                  letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1
                ),),
            
                const SizedBox(height: 50),
            
                //Email Adresse
                Text('E-Mail Adresse', textAlign: TextAlign.left, 
                style: standardTextDecoration
                ),
                const SizedBox(height: 2),
            
                MyTextFields(
                  controller: usernameController,
                  obscureText: false,
                ),
            
                const SizedBox(height: 20),
            
                //Passwort eingabe
                Text('Passwort', textAlign: TextAlign.left, 
                style: standardTextDecoration
                ),
                 const SizedBox(height: 2),
            
                MyTextFields(
                  controller: passwordController,
                  obscureText: true,
                ),
            
                 const SizedBox(height: 20),
            
                //Passwort erneut eingeben
                Text('Passwort wiederholen', textAlign: TextAlign.left, 
                style: standardTextDecoration
                ),
                 const SizedBox(height: 2),
            
                 MyTextFields(
                  controller: passwordController,
                  obscureText: true,
                ),
            
                const SizedBox(height: 25),
            
                //Registrierung Button
                Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Registrieren',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
                    widget.toggleView();
                    },
                  child:  const Text(
                    'Hier einloggen',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ))]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}