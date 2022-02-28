import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/chat.dart';
import 'package:flutter_android_app/services/chat_database.dart';

class ChatViewModel {
  ///bookview'ın state bilgilerini tutmak
  ///bookview arayzünün ihtiyacı olan metodları hesaplamaları yapmak
  ///gerekli servislerle konuşmak
  String _collectionPath = 'chat';
  ChatDatabase _database = ChatDatabase();

  static Stream<List<ChatInfo>> getChatList(String chatroomId) =>
      FirebaseFirestore.instance
          .collection('chat')
          .where('chatroomId', isEqualTo: chatroomId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatInfo.fromMap(doc.data()))
              .toList());

  static Stream<List<ChatInfo>> getPrivateChatList(
      String userId, String otherId) {
    return FirebaseFirestore.instance
        .collection('chat')
        .orderBy(ChatInfoField.time, descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatInfo.fromMap(doc.data())).toList());
  }

  static Future<void> addNewChat({required ChatInfo chat}) async {
    /// Form alanındaki veriler ile önce bir book objesi oluşturacak
    final docChat = FirebaseFirestore.instance.collection('chat').doc();

    ChatInfo chatInfo = ChatInfo(
      chatId: docChat.id,
      senderUser: chat.senderUser,
      receiverUser: chat.receiverUser,
      message: chat.message,
      time: DateTime.now(),
      chatroomId: chat.chatroomId,
      userId: chat.userId,

      //  users: users,
    );

    /// bu kitap bilgisine database servisi üzerinden firestore a yazacak
    await docChat.set(chatInfo.toMap());
  }
}
