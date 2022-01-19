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

  // Stream<List<Users>> getUsersList() {
  //   ///stream<QuerySnapShot> --> Stream<List<DocumentSnapshot>>
  //
  //   Stream<List<DocumentSnapshot>> streamListDocument = _database
  //       .getUsersListFromApi(_collectionPath)
  //       .map((querySnapshot) => querySnapshot.docs);
  //
  //   /// Stream<List<DocumentSnapshot>>   --->  Stream<List<Book>>
  //   Stream<List<Users>> streamListUsers = streamListDocument.map(
  //       (listOfDocumentSnap) => listOfDocumentSnap
  //           .map((docSnap) => Users.fromMap(docSnap.data() as Map))
  //           .toList());
  //
  //   return streamListUsers;
  // }

  Stream<List<Users>> getUsersList() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromMap(doc.data())).toList());

  List<Users> usersList = [];

  void addNewUserProvider(Users users) {
    usersList.add(users);
    notifyListeners();
  }

  Future<void> addNewUser({
    required String users,
  }) async {
    /// Form alanındaki veriler ile önce bir book objesi oluşturacak
    Users newUser = Users(id: DateTime.now().toIso8601String(), users: users);

    /// bu kitap bilgisine database servisi üzerinden firestore a yazacak
    await _database.setUserData(
        collectionPath: _collectionPath, usersAsMap: newUser.toMap());
  }
}
