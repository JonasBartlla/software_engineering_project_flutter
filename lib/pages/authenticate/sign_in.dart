import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 51, 40),
        elevation: 0.0,
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: TextButton(
          child: Text('Sign in'),
          onPressed: () async {
              dynamic result =  await _auth.signInAnonym();
              if (result == null){
                print('Während der Anmeldung ist ein Fehler aufgetreten');
              }else {
                print(result.uid);
              }
          },
        ),
      ),
    );
  }
}