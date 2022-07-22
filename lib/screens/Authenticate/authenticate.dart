import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kofee_with_code/screens/Authenticate/register.dart';
import 'package:kofee_with_code/screens/Authenticate/sign_in.dart';
class Authenticate extends StatefulWidget {
  //const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    //future: Firebase.initializeApp();
    if(showSignIn){
      return SignIn(toggleView : toggleView);
    }else{
      return Register(toggleView : toggleView);
    }
  }
}