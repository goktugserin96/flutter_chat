import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/users.dart';

class UserViewModel {
  ///bookview'ın state bilgilerini tutmak
  ///bookview arayzünün ihtiyacı olan metodları hesaplamaları yapmak
  ///gerekli servislerle konuşmak

  static Stream<List<Users>> getUsersList() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromMap(doc.data())).toList());

  static Future<void> updateUserOnline(
      {required Users users, required String userId}) async {
    final user = FirebaseFirestore.instance.collection('users').doc(userId);

    await user.update(users.toMap());
  }

  static Future<void> addNewUser(
      {required Users users, required bool isOnline}) async {
    final user = FirebaseFirestore.instance.collection('users').doc();

    Users newUsers = Users(
      users: users.users,
      id: user.id,
      email: users.email,
      isOnline: isOnline,
    );

    await user.set(newUsers.toMap());
  }
}

//

//
// Future<void> addNewUser({required Users users}) async {
//   final user = FirebaseFirestore.instance.collection('users').doc();
//
//   // final newUser = Users(
//   //   users: users.users,
//   //   id: user.id,
//   //   email: users.email,
//   // );
//
//   await _database.setUserData(
//       collectionPath: _collectionPath, usersAsMap: usersList[0].toMap());
// }
