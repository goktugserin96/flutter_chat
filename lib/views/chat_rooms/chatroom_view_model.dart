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

  // Stream<List<ChatRooms>> getChatroomList() {
  //   ///stream<QuerySnapShot> --> Stream<List<DocumentSnapshot>>
  //
  //   Stream<List<DocumentSnapshot>> streamListDocument = _database
  //       .getChatroomListFromApi(_collectionPath)
  //       .map((querySnapshot) => querySnapshot.docs);
  //
  //   /// Stream<List<DocumentSnapshot>>   --->  Stream<List<Book>>
  //   Stream<List<ChatRooms>> streamListChat = streamListDocument.map(
  //       (listOfDocumentSnap) => listOfDocumentSnap
  //           .map((docSnap) => ChatRooms.fromMap(docSnap.data() as Map))
  //           .toList());
  //
  //   return streamListChat;
  // }

  Stream<List<ChatRooms>> getChatroomList() => FirebaseFirestore.instance
      .collection('chatroomyeni')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatRooms.fromMap(doc.data())).toList());

  // List<ChatRooms> chatroomList = [];
  //
  // void addNewchatroomProvider(ChatRooms chatRooms) {
  //   chatroomList.add(chatRooms);
  //   notifyListeners();
  // }

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

    // bu kitap bilgisine database servisi üzerinden firestore a yazacak
    await _database.setChatroomData(
        collectionPath: _collectionPath, chatroomAsMap: newChatroom.toMap());
  }

  Future<void> deleteUser(Users users) async {
    await _database.deleteDocument(
        referancePath: _collectionPath, id: users.id);
  }

//   Future<void> addNewChatroom({required String roomName}) async {}
}
