import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:software_engineering_project_flutter/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';



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

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password, String displayName) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new document for the user with the uid
      DatabaseService _database = DatabaseService(uid: user!.uid);
      await _database.updateUserDate(user.uid, displayName, user.email, 'https://media.istockphoto.com/id/1208175274/vector/avatar-vector-icon-simple-element-illustrationavatar-vector-icon-material-concept-vector.jpg?s=612x612&w=0&k=20&c=t4aK_TKnYaGQcPAC5Zyh46qqAtuoPcb-mjtQax3_9Xc=');
      await _database.initializeCollection();

      print('created record');
      
      return user;
    } catch (e) {
      print(e.toString());
      return e.toString();
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

  Future<User> signInWithGoogleWeb() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  // googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({
    'login_hint': 'user@example.com'
  });

  // Once signed in, return the UserCredential
  UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(googleProvider);
  User? user = userCredential.user;
  //create a new document for the user with the uid
  DatabaseService _database = DatabaseService(uid: user!.uid);
  AggregateQuerySnapshot aggregatedQuery = await _database.userCollection.where('uid', isEqualTo: user.uid).count().get();
  if( aggregatedQuery.count == 0){
    _database.initializeCollection();
    _database.updateUserDate(user.uid, user.displayName, user.email, user.photoURL);
  }else{
    print('user already exists');
  }
  return user;
  
  
}


  // Methode zum ausloggen
  Future signOut(String uid) async {
    try{
      DatabaseService _databaseService = DatabaseService();
      await _databaseService.updateToken(uid, "");
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}