import 'package:chat_firebase/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  final Function toggle;
  SignInScreen(this.toggle);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      appBar: appBarWithTitle(context, 'Sign In'),
      body: Center(
        child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      style: normalTextWhite(),
                      decoration: inputDecoration('Email','Your email',''),
                    ),
                    SizedBox(height:8),
                    TextField(
                      style: normalTextWhite(),
                      decoration: inputDecoration('Password','Your email',''),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Forget password?', style: normalTextWhite(),),
                      ),
                    ),
                    SizedBox(height:8),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: decorationButton( Colors.blue,30),
                      child: Text('Sign In', style: normalTextStyleButton(Colors.white),),
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
}
