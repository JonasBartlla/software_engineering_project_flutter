import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{

  final FirebaseAuth _auth = FirebaseAuth.instance; 

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  
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
              
              controller: _usernameController,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _emailController,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _signUp, 
              child: Text('sign in')
            )
          ]
        ),
      ),
    );
  }
  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    if(userCredential.user != null){
      print('User is succes');
    }else{
      print('A error occured');
    }
  }
}

