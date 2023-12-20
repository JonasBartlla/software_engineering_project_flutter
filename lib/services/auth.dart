import 'dart:html';
import 'package:software_engineering_project_flutter/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebaseUSer

  CustomUser _userFromFirebaseUser(UserCredential userCredential){
    final user = userCredential.user;
    if (user != null) {
      return CustomUser(uid: user.uid);
    }
    else{
      throw Exception("User is null") ;
    }
  }

  // Methode zum Anlegen eines neuen Benutzer mit Email und Passwort
  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
     try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
     } catch (e){
      print('Some error occured');
     }
     return null;
  }

  // Methode zum Anmelden eines Benutzers durch EIngabe der EMail und des Passworts
  Future<User?> signImWithEmailAndPassword(String email, String password) async{
     try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
     } catch (e){
      print('Some error occured');
     }
     return null;
  }

  //annonyme Anmeldung
  Future signInAnonym() async {
    try{
      UserCredential user  = await _auth.signInAnonymously();
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


}