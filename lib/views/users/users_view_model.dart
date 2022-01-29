import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_android_app/models/users.dart';
import 'package:flutter_android_app/services/users_database.dart';

class UserViewModel extends ChangeNotifier {
  ///bookview'ın state bilgilerini tutmak
  ///bookview arayzünün ihtiyacı olan metodları hesaplamaları yapmak
  ///gerekli servislerle konuşmak
  String _collectionPath = 'users';
  UsersDatabase _database = UsersDatabase();

  Stream<List<Users>> getUsersList() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromMap(doc.data())).toList());

  List<Users> usersList = [];

  Future<void> addNewUser({required String users}) async {
    final user = FirebaseFirestore.instance.collection('chat').doc();

    usersList.add(Users(
      users: users,
      id: user.id,
    ));

    await _database.setUserData(
        collectionPath: _collectionPath, usersAsMap: usersList[0].toMap());
  }
}
