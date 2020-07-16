import 'package:chat_firebase/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChatConversationScreen extends StatefulWidget {
  ChatConversationScreen({String userName});
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversationScreen> {
  _ChatConversationState({String userName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context, 'hih'),
      body: Container(

      ),
    );
  }
}
