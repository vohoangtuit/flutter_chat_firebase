import 'package:chat_firebase/firebase_services/firebasse_database.dart';
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
                  Expanded(child: TextField(
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
    firebaseDB.getUserByUsername(searchEditingController.text)
        .then((data){
          setState(() {
            querySnapshot =data;
          });
    }
    );
  }
  void createChatRoomAndStartConversation(String userName){
    List<String> users =[userName];
    //firebaseDB.createChatRoom(chatRoomId, chatRoomMap);
  }
  Widget userList(){
    return querySnapshot!=null?ListView.builder(
      itemCount: querySnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
        print('userName ' +querySnapshot.documents[index].data['userName']);
        return SearchItem(userName: querySnapshot.documents[index].data['userName'],email: querySnapshot.documents[index].data['email'],);
    }):Container(
    );
  }
}
class SearchItem extends StatelessWidget {
   String userName;
   String email;
   SearchItem({this.userName,this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName,style: mediumTextWhite(),),
              Text(email,style: mediumTextWhite(),),
            ],
          ), Spacer(),
          GestureDetector(
            onTap: (){

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
}
