import 'dart:html';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/models/app_user.dart';
import 'package:software_engineering_project_flutter/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? userEmail;
  String? name;
  String? uid;

  
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

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new document for the user with the uid
      DatabaseService _database = DatabaseService(uid: user!.uid);
      await _database.updateUserDate(user.uid, user.email, user.email);
      await _database.initializeCollection();
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

  //Google Signin Methoden
  Future<User?> signInWithGoogle() async{
    User? user;

    if (kIsWeb){
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
      final UserCredential userCredential = await _auth.signInWithPopup(authProvider);
      user = userCredential.user;
    }
    catch(e){
      print(e);
    }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        try {
          final UserCredential userCredential = await _auth.signInWithCredential(credential);
          user = userCredential.user;
        }
        on FirebaseAuthException catch(e){
          if(e.code == 'account-exists-with-different-credential'){
            print('Der Account existier bereits mit anderen Daten');
          } else if(e.code == 'invalid-credential'){
            print('Falsche Zugangsdaten. Bitte erneut versuchen');
          } 
        } catch (e) {
          print(e);
        }
      }
    }
    if  (user != null){
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
    }
    return user;
  }
  void signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', false);

    uid = null;
    name = null;
    userEmail = null;

    print('Benutzer wurde abgemeldet');
  }
  
}