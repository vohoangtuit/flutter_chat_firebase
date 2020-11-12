import 'package:chat_firebase/firebase_services/firebase_auth.dart';
import 'package:chat_firebase/firebase_services/firebasse_database.dart';
import 'package:chat_firebase/shared_preferences/shared_preference.dart';
import 'package:chat_firebase/utils/constants.dart';
import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';

class SignInScreen extends StatefulWidget {
  final Function toggle;
  SignInScreen(this.toggle);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  FireBaseAuth fireBaseAuth = new FireBaseAuth();
  FirebaseDatabaseMethods firebaseDB = new FirebaseDatabaseMethods();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      appBar: appBarWithTitle(context, 'Sign In'),
      body: Center(
        child: isLoading?CircularProgressIndicator():SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Form(
                     key: formKey,
                     child: Column(children: <Widget>[
                       TextFormField(
                         controller: emailEditingController,
                         style: normalTextWhite(),
                         decoration: inputDecoration('Email','Your email',''),
                         validator: (val){
                           return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                           null : "Enter correct email";
                         },
                       ),
                       SizedBox(height:8),
                       TextFormField(
                         controller: passwordEditingController,
                         obscureText: true,
                         style: normalTextWhite(),
                         decoration: inputDecoration('Password','Your password',''),
                         validator: (val) {
                           return val.length >= 6
                               ? null
                               : "Enter Password 6+ characters";
                         },

                       ),
                     ],),
                   ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Forget password?', style: normalTextWhite(),),
                      ),
                    ),
                    SizedBox(height:8),
                    GestureDetector(
                      onTap: (){handleSignIn();},
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: decorationButton( Colors.blue,30),
                        child: Text('Sign In', style: normalTextStyleButton(Colors.white),),
                      ),
                    ),
                    SizedBox(height:16),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: decorationButton( Colors.white,30),
                      child: Text('Sign In with Google', style: normalTextStyleButton(Colors.black),),
                    ),
                    SizedBox(height:16),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                      Text("Don't have account? ",style: normalTextWhite(),),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text("Register now",style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 14),)
                        ),
                      )
                    ],)
                  ],
                ),
            ),

        ),
      ),
    );
  }

  void handleSignIn(){
    QuerySnapshot  userInfo;
    if(formKey.currentState.validate()){
      setState(() {
        isLoading =true;
      });
      fireBaseAuth.signInWithEmailAndPassWord(emailEditingController.text, passwordEditingController.text).then((data){

        if(data!=null){
          firebaseDB.getUserByEmail(emailEditingController.text).then((data){
            userInfo = data;
            SharedPre.saveBool(SharedPre.sharedPreIsLogin, true);
            SharedPre.saveString(SharedPre.sharedPreUserName, userInfo.documents[0].data[Constants.username]);
            SharedPre.saveString(SharedPre.sharedPreUserEmail, userInfo.documents[0].data[Constants.email]);
            Future.delayed(
              Duration(seconds: 3),
                  () async {
                    setState(() {
                      isLoading =false;
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>ChatRoomScreen()));
              },
            );
          });
        }else{
          setState(() {
            isLoading =false;
          });
          print("Error SignIn");
        }
      });
    }
  }
}
