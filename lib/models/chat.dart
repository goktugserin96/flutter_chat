import 'package:cloud_firestore/cloud_firestore.dart';

class ChatInfoField {
  static const time = 'time';
}

class ChatInfo {
  final String chatId;
  final String chatroomId;
  final String senderUser;
  final String receiverUser;
  final String message;
  final DateTime time;
  final String userId;
  //final List<Users> users;

  ChatInfo({
    this.chatId = "",
    required this.chatroomId,
    this.senderUser = "",
    this.receiverUser = "",
    required this.message,
    required this.time,
    required this.userId,
    // required this.users,
  });

  ///firebaseden obje olarka gelmiyor map olarak geliyor biz de yazarken map olarak yazıcaz bu yüzden objeden map oluşturan bir method lazım

  Map<String, dynamic> toMap() => {
        // List<Map<String, dynamic>> borrows =
        //     this.borrows.map((e) => e.toMap()).toList();

        'chatId': chatId,
        'chatroomId': chatroomId,
        'senderUser': senderUser,
        'receiverUser': receiverUser,
        'message': message,
        'time': time,
        'userId': userId,
        //  'users': List<dynamic>.from(users.map((x) => x.toMap()))
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.

  factory ChatInfo.fromMap(Map map) => ChatInfo(
        chatId: map['chatId'],
        chatroomId: map['chatroomId'],
        senderUser: map['senderUser'],
        receiverUser: map['receiverUser'],
        message: map['message'],
        time: (map['time'] as Timestamp).toDate(),
        userId: map['userId'],
        // users: List<Users>.from(
        //   map['users'].map(
        //     (x) => Users.fromMap(x),
        //   ),
        // ),
      );
}
