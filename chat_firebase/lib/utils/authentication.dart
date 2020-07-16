import 'package:chat_firebase/views/signin.dart';
import 'package:chat_firebase/views/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignInScreen(toggleView);
    }
    else{
      return SignUpScreen(toggleView);
    }
  }
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
}
