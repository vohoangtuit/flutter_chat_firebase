import 'package:chat_firebase/models/user.dart';
import 'package:chat_firebase/shared_preferences/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(userID: user.uid) : null;
  }

  Future signInWithEmailAndPassWord(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print('Error SignIn ${e.toString()}');
    }
  }

  //
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print('Error SignUp ${e.toString()}');
    }
  }

  //
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error Reset pass ' + e.toString());
    }
  }

  //
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Error SignOut ${e.toString()}');
    }
  }
}
