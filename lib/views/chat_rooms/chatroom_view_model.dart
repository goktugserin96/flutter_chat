import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:flutter_android_app/services/chatroom_database.dart';

class ChatroomViewModel extends ChangeNotifier {
  ///bookview'ın state bilgilerini tutmak
  ///bookview arayzünün ihtiyacı olan metodları hesaplamaları yapmak
  ///gerekli servislerle konuşmak
  String _collectionPath = 'chatroomyeni';
  ChatroomDatabase _database = ChatroomDatabase();

  List<Users> _chatroomUserList = [];

  List<Users> get chatroomUserList => _chatroomUserList;

  void chatUsersAdd(Users users) {
    _chatroomUserList.add(users);
    notifyListeners();
  }

  Stream<List<ChatRooms>> getChatroomList() => FirebaseFirestore.instance
      .collection('chatrooms')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatRooms.fromMap(doc.data())).toList());

  Future<void> deleteUser(Users users) async {
    await _database.deleteDocument(
        referancePath: _collectionPath, id: users.id);
  }
}
