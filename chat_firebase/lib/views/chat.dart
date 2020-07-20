import 'package:chat_firebase/firebase_services/firebasse_database.dart';
import 'package:chat_firebase/utils/constants.dart';
import 'package:chat_firebase/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String userName;
  ChatScreen(this.chatRoomId,this.userName);
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatScreen> {
  final TextEditingController messageController = new TextEditingController();
  FirebaseDatabaseMethods firebaseDB = new FirebaseDatabaseMethods();
  Stream chats;
  @override
  void initState() {
    super.initState();
    getAllMessage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context, widget.userName),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                color: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(child: TextField(
                      controller: messageController,
                      style: normalTextWhite(),
                      decoration: InputDecoration(
                        hintText: 'Message....',
                        hintStyle: normalTextWhite(),
                        border: InputBorder.none,
                      ),
                    )),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
                      },
                      child: Container(
                          width: 40,height: 40,
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image.asset('assets/images/send.png',)
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTitle(
               snapshot.data.documents[index].data["message"],
                Constants.myName == snapshot.data.documents[index].data["sendBy"],
              );
            }) : Container(
          child: Text(""),
        );
      },
    );
  }
  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> mapMessage={
        "message":messageController.text,
        "sendBy":Constants.myName,
        "times": DateTime.now().millisecondsSinceEpoch
    };
      firebaseDB.addMessageToConversation(widget.chatRoomId,mapMessage);
      messageController.text="";
    }
  }
  getAllMessage(){
    firebaseDB.getMessageFromConversation(widget.chatRoomId).then((data){
      setState(() {
        chats = data;
      });
    });
  }
}

class MessageTitle extends StatelessWidget {
  String message;
  bool isSendByMe;
  MessageTitle(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe?70:18, right: isSendByMe?18:70),
      margin: EdgeInsets.symmetric(vertical: 7),
      width: MediaQuery.of(context).size.width,
      alignment:isSendByMe? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        decoration: isSendByMe?decorationMessageRight():decorationMessageLeft(),
          child: Text(message,style: textMessage(),)),
    );
  }
}

