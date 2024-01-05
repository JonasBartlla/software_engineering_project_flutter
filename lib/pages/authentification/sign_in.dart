import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/shared/textfields.dart';
import 'package:software_engineering_project_flutter/pages/authentification/register.dart';
import 'package:software_engineering_project_flutter/pages/authentification/authenticate.dart';


class SignIn extends StatefulWidget {
  
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                
                MyTextFields(
                  controller: usernameController,
                  obscureText: false,
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

                MyTextFields(
                  controller: passwordController,
                  obscureText: true,
                ),
            
                const SizedBox(height: 25),
            
                //log in Button
                Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 15),
            
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
                    widget.toggleView();
                    },
                  child: const Text(
                    'Hier registrieren',
                    style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  ))]
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}