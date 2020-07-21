import 'package:chat_firebase/firebase_services/firebase_auth.dart';
import 'package:chat_firebase/firebase_services/firebasse_database.dart';
import 'package:chat_firebase/shared_preferences/shared_preference.dart';
import 'package:chat_firebase/utils/authentication.dart';
import 'package:chat_firebase/utils/constants.dart';
import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/views/chat.dart';
import 'package:chat_firebase/views/search.dart';
import 'package:chat_firebase/views/signin.dart';
import 'package:chat_firebase/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  FireBaseAuth authMethods = new FireBaseAuth();
  FirebaseDatabaseMethods firebaseDatabaseMethods = new FirebaseDatabaseMethods();
  Stream chatRoomStream;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }
  getUserInfo()async{
    Constants.myName =await SharedPre.getStringKey(SharedPre.sharedPreUserName);
    firebaseDatabaseMethods.getUserChats(Constants.myName).then((data){
      setState(() {
        chatRoomStream = data;
        print(
            "we got the data + ${chatRoomStream.toString()} this is name  ${Constants.myName}");
      });
    });
  }
  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData?ListView.builder(
          itemCount: snapshot.data.documents.length,// snapshot.data.documents.length
            itemBuilder: (context,index){
              return ChatRoomItem(snapshot.data.documents[index].data[FirebaseDatabaseMethods().CHATROOM_KEY_ID].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),snapshot.data.documents[index].data[FirebaseDatabaseMethods().CHATROOM_KEY_ID]);
        }):Container();
      },

    );
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
              SharedPre.clearData();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body:  chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
        },
      ),
    );
  }
}

class ChatRoomItem extends StatelessWidget {
  String userName;
  String chatRoomId;
  ChatRoomItem(this.userName,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        String userName =chatRoomId.replaceAll("_", "").replaceAll(Constants.myName, "");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(chatRoomId,userName)));
      },
      child: Container(
        color: Colors.grey,
        margin: EdgeInsets.only(bottom: 2),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 40,height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text(userName.substring(0,1).toUpperCase(),style: mediumTextWhite(),),
            ),
            SizedBox(width: 8,),
            Text(userName,style: mediumTextWhite(),),
          ],
        ),
      ),
    );
  }
}

