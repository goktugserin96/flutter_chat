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

  Stream<List<ChatRooms>> getChatroomList() => FirebaseFirestore.instance
      .collection('chatroomyeni')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatRooms.fromMap(doc.data())).toList());

  Future<void> addNewChatroomUsers({
    required ChatRooms chatRooms,
    required String chatRoomsName,
    required List<Users> userList,
  }) async {
    /// Form alanındaki veriler ile önce bir book objesi oluşturacak
    ///
    //  final docUser = FirebaseFirestore.instance.collection(_collectionPath).doc();
    ChatRooms newChatroom = ChatRooms(
      id: chatRooms.id,
      name: chatRoomsName,
      chatroomUsers: userList,
      //   chatroomUsers: usersList,
      // chatOfChatroom: chatInfoList,
    );

    await _database.setChatroomData(
        collectionPath: _collectionPath, chatroomAsMap: newChatroom.toMap());
  }

  Future<void> deleteUser(Users users) async {
    await _database.deleteDocument(
        referancePath: _collectionPath, id: users.id);
  }
}
