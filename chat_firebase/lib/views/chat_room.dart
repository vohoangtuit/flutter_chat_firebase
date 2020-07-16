import 'package:chat_firebase/firebase_services/firebase_auth.dart';
import 'package:chat_firebase/utils/authentication.dart';
import 'package:chat_firebase/utils/constants.dart';
import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/views/search.dart';
import 'package:chat_firebase/views/signin.dart';
import 'package:chat_firebase/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  FireBaseAuth authMethods = new FireBaseAuth();
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }
  getUserInfo()async{
    Constants.myName =await UtilsFunctions.getStringKey(UtilsFunctions.sharedPreUserName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
        },
      ),
    );
  }
}
