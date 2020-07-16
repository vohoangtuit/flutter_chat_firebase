import 'package:chat_firebase/utils/authentication.dart';
import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/views/chat_room.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoginApp =false;
  @override
  void initState() {
    super.initState();
    checkUserLogin();
  }
  checkUserLogin()async{
    await UtilsFunctions.getBoolKey(UtilsFunctions.sharedPreIsLogin).then((value) {
      if(value!=null){
        setState(() {
          isLoginApp =value;
        });
      }
    });
  }
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
      //home:  isLoginApp?ChatRoomScreen():Authenticate(),
      home: isLoginApp != null ?  isLoginApp ? ChatRoomScreen() : Authenticate()
          : Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
    );
  }
}
