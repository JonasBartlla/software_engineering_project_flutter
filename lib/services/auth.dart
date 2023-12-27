import 'dart:html';
import 'package:software_engineering_project_flutter/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/services/database.dart';

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

  // liefert einen Stream um über die Veränderung des Authentifizierungsstatuses zu informieren
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


  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserDate('new User', 'sport', 40);
      print('created record');
      
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Methode zum ausloggen
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  
}