import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/chat.dart';

class ChatDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// FireStore servisinden kitapların verisini stream olarak alıp sağlamak

  Stream<QuerySnapshot> getChatListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  /// FireStore üzerinde bir veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referancePath, required String id}) async {
    await _firestore.collection(referancePath).doc(id).delete();
  }

//   }

  /// FireStore' a yeni bilgi ekleme ve güncelleme hizmeti sağlamak
  Future<void> setChatData(
      {required String collectionPath,
      required Map<String, dynamic> chatAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(ChatInfo.fromMap(chatAsMap).chatId)
        .set(chatAsMap);
  }
}
