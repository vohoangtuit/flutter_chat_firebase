import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseMethods {
  final TAG_USER_COLLECTION = 'users';
  final USER_KEY_NAME ='userName';
  final USER_KEY_EMAIL ='email';

  final TAG_CHATROOM_COLLECTION = 'ChatRoom';

  getUserByUsername(String username) async{
    return await Firestore.instance.collection(TAG_USER_COLLECTION).where(USER_KEY_NAME,isEqualTo: username).getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance
        .collection(TAG_USER_COLLECTION)
        .add(userMap)
        .catchError((e) {
      print("error " + e.toString());
    });
  }

  createChatRoom(String chatRoomId, Map chatRoomMap){
    Firestore.instance.collection(TAG_CHATROOM_COLLECTION).document(chatRoomId).setData(chatRoomMap).catchError((e){
      print("error createChatRoom " + e.toString());
    });
  }
}
