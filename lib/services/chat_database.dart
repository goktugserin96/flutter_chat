import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/chat.dart';

class ChatDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// FireStore servisinden kitapların verisini stream olarak alıp sağlamak

  /// FireStore üzerinde bir veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referancePath, required String id}) async {
    await _firestore.collection(referancePath).doc(id).delete();
  }

//   }

  /// FireStore' a yeni bilgi ekleme ve güncelleme hizmeti sağlamak
  // Future<void> setChatData(
  //     {required String collectionPath,
  //     required Map<String, dynamic> chatAsMap}) async {
  //   await _firestore
  //       .collection(collectionPath)
  //       .doc(ChatInfo.fromMap(chatAsMap).chatId)
  //       .set(chatAsMap);
  // }

  static Future addChatInitial(List<ChatInfo> chats) async {
    final refChat = FirebaseFirestore.instance.collection('chat');

    final allChat = await refChat.get();
    if (allChat.size != 0) {
      return;
    } else {
      for (final chat in chats) {
        final chatDoc = refChat.doc();
        final newChat = chat.copyWith(
            userId: chat.userId,
            chatroomId: chat.chatroomId,
            chatId: chat.chatId,
            senderUser: chat.senderUser,
            message: chat.message,
            time: chat.time,
            translatedMessage: chat.translatedMessage,
            receiverUser: chat.receiverUser);

        await chatDoc.set(newChat.toMap());
      }
    }
  }
}
