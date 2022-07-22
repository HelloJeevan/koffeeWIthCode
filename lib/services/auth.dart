import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:kofee_with_code/models/user.dart';
import 'package:kofee_with_code/services/services.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  //create user obj based on firebase user
  objUser? _userFromFirebaseUser(User user){
    return user!=null?objUser(uid: user.uid ):null;
  }

  //auth change user stream
  Stream<objUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }
  //sign with annon
  Future signInWithAnon() async{
    //await Firebase.initializeApp();
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
      
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign with login pass
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       User? user = result.user;
       return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign up
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User? user = result.user;
       //create a new document for the user with user uid
       await databaseService(uid: user!.uid).updateUserData('0','new member',100);
       return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}