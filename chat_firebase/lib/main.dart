import 'package:chat_firebase/views/signin.dart';
import 'package:chat_firebase/views/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TChat',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primaryColor: Color(0xff145C9E),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: SigInScreen(),
      home: SignUpScreen(),
    );
  }
}
