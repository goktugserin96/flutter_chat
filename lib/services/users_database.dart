import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/users.dart';

class UsersDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// FireStore servisinden kitapların verisini stream olarak alıp sağlamak

  /// FireStore üzerinde bir veriyi silme hizmeti
  Future<void> deleteDocument(
      {required String referancePath, required String id}) async {
    await _firestore.collection(referancePath).doc(id).delete();
  }

//   }

  // Future<void> setUserData(
  //     {required String collectionPath,
  //     required Map<String, dynamic> usersAsMap}) async {
  //   await _firestore
  //       .collection(collectionPath)
  //       .doc(Users.fromMap(usersAsMap).id)
  //       .set(usersAsMap);
  // }
}
