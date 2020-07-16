import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDatabaseMethods {
  final TAG_USER_COLLECTION = 'users';
  final USER_KEY_NAME ='name';
  final USER_KEY_EMAIL ='email';

  final TAG_CHATROOM_COLLECTION = 'ChatRoom';

  getUserByUserName(String username) async{
    return await Firestore.instance.collection(TAG_USER_COLLECTION).where(USER_KEY_NAME,isEqualTo: username).getDocuments();
  }

  getUserByEmail(String email) async{
    return await Firestore.instance.collection(TAG_USER_COLLECTION).where(USER_KEY_EMAIL,isEqualTo: email).getDocuments().catchError((e){
      print("Error get info by email ${e.toString()}");
    });
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
