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

  Stream<User?> get user {
    return _auth.authStateChanges();
  
  }

  //annonyme Anmeldung
  Future signInAnonym() async {
    try{
      UserCredential userCredential  = await _auth.signInAnonymously();
      return userCredential.user;
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  
}