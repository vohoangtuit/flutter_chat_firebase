import 'package:chat_firebase/firebase_services/firebasse_database.dart';
import 'package:chat_firebase/utils/constants.dart';
import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/views/chat.dart';
import 'package:chat_firebase/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirebaseDatabaseMethods firebaseDB = new FirebaseDatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context,'Search'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: Colors.grey,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: searchEditingController,
                    style: normalTextWhite(),
                    decoration: InputDecoration(
                      hintText: 'search username.....',
                      hintStyle: normalTextWhite(),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: (){
                      handleSearch();
                    },
                    child: Container(
                       width: 40,height: 40,
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset('assets/images/search_white.png',)
                    ),
                  )
                ],
              ),
            ),
            userList(),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  void handleSearch(){
    firebaseDB.getUserByUserName(searchEditingController.text)
        .then((data){
          setState(() {
            querySnapshot =data;
          });
    }
    );
  }
  Widget userList(){
    return querySnapshot!=null?ListView.builder(
      itemCount: querySnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
       // print('name ' +querySnapshot.documents[index].data[Constants.name]);
        return SearchItem(userName: querySnapshot.documents[index].data[Constants.name],userEmail: querySnapshot.documents[index].data[Constants.email],);
    }):Container(
    );
  }
  Widget SearchItem({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName,style: mediumTextWhite(),),
              Text(userEmail,style: mediumTextWhite(),),
            ],
          ), Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Text('Message',style: mediumTextWhite(),),
            ),
          ),
        ],
      ),
    );
}
  createChatRoomAndStartConversation(String userName){
    if(userName!= Constants.myName){
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users =[userName, Constants.myName];
      Map<String, dynamic> chatRoomMap={
        "users":users,
        "chatroomId":chatRoomId
      };
      FirebaseDatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ChatScreen(chatRoomId,userName)));
    }else{
      print('You cannot send message to yourself');
    }

  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

