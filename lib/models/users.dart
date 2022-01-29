class Users {
  final String users;
  final String id;
  // final List<ChatInfo> dm;

  Users({
    required this.users,
    required this.id,
    // required this.dm,
  });

  ///firebaseden obje olarka gelmiyor map olarak geliyor biz de yazarken map olarak yazıcaz bu yüzden objeden map oluşturan bir method lazım
  Map<String, dynamic> toMap() => {
        'users': users,
        'id': id,
        // 'dm': List<dynamic>.from(dm.map((x) => x.toMap())),
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.
  factory Users.fromMap(Map map) => Users(
        users: map['users'],
        id: map['id'],
        // dm: List<ChatInfo>.from(
        //   map['dm'].map(
        //     (x) => ChatInfo.fromMap(x),
        //   ),
        // ),
      );
}
