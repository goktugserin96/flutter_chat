class ChatRooms {
  final String id;
  final String name;
  final String flagImage;

  // final List<Users> chatroomUsers;

  ChatRooms({this.id = "", required this.name, required this.flagImage
      // required this.chatroomUsers,
      });

  ChatRooms copyWith({
    required String id,
    required String name,
    required String flagImage,
  }) =>
      ChatRooms(id: id, name: name, flagImage: flagImage);

  Map<String, dynamic> toMap() => {
        // List<Map<String, dynamic>> borrows =
        //     this.borrows.map((e) => e.toMap()).toList();

        'id': id,
        'name': name,
        'flagImage': flagImage,
        // 'chatroomUsers':
        //     List<dynamic>.from(chatroomUsers.map((x) => x.toMap())),
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.

  factory ChatRooms.fromMap(Map map) => ChatRooms(
        id: map['id'],
        name: map['name'],
        flagImage: map['flagImage'],
        // chatroomUsers: List<Users>.from(
        //   map['chatroomUsers'].map(
        //     (x) => Users.fromMap(x),
        //   ),
        // ),
      );
}
