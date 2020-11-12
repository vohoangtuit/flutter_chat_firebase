
import 'package:chat_firebase/firebase_services/firebase_auth.dart';
import 'package:chat_firebase/firebase_services/firebasse_database.dart';
import 'package:chat_firebase/shared_preferences/shared_preference.dart';
import 'package:chat_firebase/utils/constants.dart';
import 'package:chat_firebase/utils/utils.dart';
import 'package:chat_firebase/views/chat_room.dart';
import 'package:chat_firebase/widgets/widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggle;
  SignUpScreen(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  bool isLoading =false;
  final formKey = GlobalKey<FormState>();
  FireBaseAuth firebaseAuth = new FireBaseAuth();

  FirebaseDatabaseMethods firebaseDB = new FirebaseDatabaseMethods();

  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context, 'Sign Up'),
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
                      style: normalTextWhite(),
                      decoration: inputDecoration('Email','Username',''),
                      controller: userNameEditingController,
                      validator: (val){
                        return  val.isEmpty || val.length<4?'Please enter username valid':null;
                      },
                    ),
                    SizedBox(height:8),
                    TextFormField(
                      style: normalTextWhite(),
                      decoration: inputDecoration('Email','Email',''),
                      controller: emailEditingController,
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                        null : "Enter correct email";
                      },
                    ),
                    SizedBox(height:8),
                    TextFormField(
                      obscureText: true,
                      style: normalTextWhite(),
                      decoration: inputDecoration('Password','Password',''),
                      controller: passwordEditingController,
                      validator:  (val){
                        return val.length < 6 ? "Enter Password 6+ characters" : null;
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
                  onTap: (){
                    print('Click');
                    handelSignUp();

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: decorationButton( Colors.blue,30),
                    child: Text('Sign Up', style: normalTextStyleButton(Colors.white),),
                  ),
                ),
                SizedBox(height:16),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: decorationButton( Colors.white,30),
                  child: Text('Sign Up with Google', style: normalTextStyleButton(Colors.black),),
                ),
                SizedBox(height:16),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have account? ",style: normalTextWhite(),),
                    GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text("SignIn now",style: TextStyle(decoration: TextDecoration.underline, color: Colors.white, fontSize: 14),)))
                  ],)
              ],
            ),
          ),

        ),
      ),
    );
  }

  void handelSignUp(){
    if(formKey.currentState.validate()){
      setState(() {
        isLoading =true;
      });
      firebaseAuth.signUpWithEmailAndPassword(emailEditingController.text, passwordEditingController.text).then((data){
        print("data signin ${data.toString()}");

        Map<String, String> userInfo ={
          Constants.username: userNameEditingController.text,
          Constants.email: emailEditingController.text,
          Constants.fullName: '',
          Constants.birthday: '',
          Constants.photoURL: '',
          Constants.country: '',
          Constants.password: passwordEditingController.text,
        };
        firebaseDB.uploadUserInfo(userInfo);
        SharedPre.saveBool(SharedPre.sharedPreIsLogin, true);
        SharedPre.saveString(SharedPre.sharedPreUserName, userNameEditingController.text);
        SharedPre.saveString(SharedPre.sharedPreUserEmail, emailEditingController.text);
        Future.delayed(Duration(seconds: 3),()async{
          setState(() {
            isLoading =false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>ChatRoomScreen()));
        }
        );

      });
    }
  }
}
