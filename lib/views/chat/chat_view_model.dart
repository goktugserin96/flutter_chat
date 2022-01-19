import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/services/calculator.dart';
import 'package:flutter_android_app/services/chat_database.dart';

class ChatViewModel extends ChangeNotifier {
  ///bookview'ın state bilgilerini tutmak

  ///bookview arayzünün ihtiyacı olan metodları hesaplamaları yapmak
  ///gerekli servislerle konuşmak

  String _collectionPath = 'chat';
  ChatDatabase _database = ChatDatabase();

  // Stream<List<ChatInfo>> getChatList() {
  //   ///stream<QuerySnapShot> --> Stream<List<DocumentSnapshot>>
  //
  //   Stream<List<DocumentSnapshot>> streamListDocument = _database
  //       .getChatListFromApi(_collectionPath)
  //       .map((querySnapshot) => querySnapshot.docs);
  //
  //   /// Stream<List<DocumentSnapshot>>   --->  Stream<List<Book>>
  //   Stream<List<ChatInfo>> streamListChat = streamListDocument.map(
  //       (listOfDocumentSnap) => listOfDocumentSnap
  //           .map((docSnap) => ChatInfo.fromMap(docSnap.data() as Map))
  //           .toList());
  //
  //   return streamListChat;
  // }

  Stream<List<ChatInfo>> getChatList(String chatroomId) => FirebaseFirestore
      .instance
      .collection('chat')
      .where('chatroomId', isEqualTo: chatroomId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatInfo.fromMap(doc.data())).toList());

  // List<ChatInfo> chatInfoList = [];
  //
  // void addNewchatInfoProvider(ChatInfo chatInfo) {
  //   chatInfoList.add(chatInfo);
  //   notifyListeners();
  // }

  Future<void> addNewChat(
      {required String user,
      required String message,
      required String chatRoomsId}) async {
    /// Form alanındaki veriler ile önce bir book objesi oluşturacak
    final docChat = FirebaseFirestore.instance.collection('chat').doc();
    ChatInfo newChat = ChatInfo(
      id: docChat.id,
      user: user,
      message: message,
      time: Calculator.dateTimeToTimeStamp(DateTime.now()),
      chatroomId: chatRoomsId,

      // chatRoomList: [],
    );

    /// bu kitap bilgisine database servisi üzerinden firestore a yazacak
    await _database.setChatData(
        collectionPath: _collectionPath, chatAsMap: newChat.toMap());
  }
}
