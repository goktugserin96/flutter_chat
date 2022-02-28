

class Users {
  final String users;
  final String id;
  final String email;
  bool isOnline;


  Users({
    required this.users,
    this.id = "",
    required this.email,
    this.isOnline = false,

  });

  ///firebaseden obje olarka gelmiyor map olarak geliyor biz de yazarken map olarak yazıcaz bu yüzden objeden map oluşturan bir method lazım
  Map<String, dynamic> toMap() => {
        'users': users,
        'id': id,
        'email': email,
        'isOnline': isOnline,

      };

  /// bir de mapten obje oluştran bir yapıcıya ihtiyacımız var.
  factory Users.fromMap(Map map) => Users(
        users: map['users'],
        id: map['id'],
        email: map['email'],
        isOnline: map['isOnline'],

      );
}
