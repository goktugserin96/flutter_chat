import 'package:flutter_android_app/models/users.dart';

class ChatRooms {
  final String id;
  final String name;
  final List<Users> chatroomUsers;

  ChatRooms({
    required this.id,
    required this.name,
    required this.chatroomUsers,
  });

  Map<String, dynamic> toMap() => {
        // List<Map<String, dynamic>> borrows =
        //     this.borrows.map((e) => e.toMap()).toList();

        'id': id,
        'name': name,
        'chatroomUsers':
            List<dynamic>.from(chatroomUsers.map((x) => x.toMap())),
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.

  factory ChatRooms.fromMap(Map map) => ChatRooms(
        id: map['id'],
        name: map['name'],
        chatroomUsers: List<Users>.from(
          map['chatroomUsers'].map(
            (x) => Users.fromMap(x),
          ),
        ),
      );
}
