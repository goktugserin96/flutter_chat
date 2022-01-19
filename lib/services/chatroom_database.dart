import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/chat_rooms.dart';

class ChatroomDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// FireStore servisinden kitapların verisini stream olarak alıp sağlamak

  Stream<QuerySnapshot> getChatroomListFromApi(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  /// FireStore üzerinde bir veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referancePath, required String id}) async {
    await _firestore.collection(referancePath).doc(id).delete();
  }

//   }

  /// FireStore' a yeni bilgi ekleme ve güncelleme hizmeti sağlamak
  Future<void> setChatroomData(
      {required String collectionPath,
      required Map<String, dynamic> chatroomAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(ChatRooms.fromMap(chatroomAsMap).id)
        .set(chatroomAsMap);
  }

  // Future<void> UpdateChatroomUsers(
  //     {required String referancePath, required String id}) async {
  //   await _firestore.collection(referancePath).doc(referancePath).update({});
  // }
}
