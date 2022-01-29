import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_android_app/models/users.dart';

class ChatInfo {
  final String id;
  final String chatroomId;
  // final String user;
  final String message;
  final Timestamp time;
  //final String userId;
  final List<Users> users;

  ChatInfo({
    required this.id,
    required this.chatroomId,
    // required this.user,
    required this.message,
    required this.time,
    // required this.userId,
    required this.users,
  });

  ///firebaseden obje olarka gelmiyor map olarak geliyor biz de yazarken map olarak yazıcaz bu yüzden objeden map oluşturan bir method lazım

  Map<String, dynamic> toMap() => {
        // List<Map<String, dynamic>> borrows =
        //     this.borrows.map((e) => e.toMap()).toList();

        'id': id,
        'chatroomId': chatroomId,
        //'user': user,
        'message': message,
        'time': time,
        // 'userId': userId,
        'users': List<dynamic>.from(users.map((x) => x.toMap()))
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.

  factory ChatInfo.fromMap(Map map) => ChatInfo(
        id: map['id'],
        chatroomId: map['chatroomId'],
        //     user: map['user'],
        message: map['message'],
        time: map['time'],
        //    userId: map['userId'],
        users: List<Users>.from(
          map['users'].map(
            (x) => Users.fromMap(x),
          ),
        ),
      );
}
