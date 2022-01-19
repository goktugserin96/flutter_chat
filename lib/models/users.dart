class Users {
  final String users;
  final String id;
  Users({
    required this.users,
    required this.id,
  });

  ///firebaseden obje olarka gelmiyor map olarak geliyor biz de yazarken map olarak yazıcaz bu yüzden objeden map oluşturan bir method lazım

  Map<String, dynamic> toMap() => {
        'users': users,
        'id': id,
      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.

  factory Users.fromMap(Map map) => Users(
        users: map['users'],
        id: map['id'],
      );
}
