import 'package:cloud_firestore/cloud_firestore.dart';

class ChatInfo {
  final String id;
  final String chatroomId;
  final String user;
  final String message;
  final Timestamp time;
  // final List<ChatRooms> chatRoomList;

  ChatInfo({
    required this.id,
    required this.chatroomId,
    required this.user,
    required this.message,
    required this.time,
  });

  ///firebaseden obje olarka gelmiyor map olarak geliyor biz de yazarken map olarak yazıcaz bu yüzden objeden map oluşturan bir method lazım

  Map<String, dynamic> toMap() => {
        // List<Map<String, dynamic>> borrows =
        //     this.borrows.map((e) => e.toMap()).toList();

        'id': id,
        'chatroomId': chatroomId,
        'user': user,
        'message': message,
        'time': time,
        // 'chatRoomList': List<dynamic>.from(chatRoomList.map((x) => x.toMap()))
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.

  factory ChatInfo.fromMap(Map map) => ChatInfo(
        id: map['id'],
        chatroomId: map['chatroomId'],
        user: map['user'],
        message: map['message'],
        time: map['time'],

        // chatRoomList: List<ChatRooms>.from(
        //   map['chatRoomList'].map(
        //     (x) => ChatRooms.fromMap(x),
        //   ),
        // ),
      );
}
