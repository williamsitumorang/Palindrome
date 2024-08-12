class User {
  final int id;
  final String email;
  final String firstname;
  final String? lastname;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    required this.firstname,
    this.lastname,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_users'] ?? 0,
      email: json['email'] ?? '',
      firstname: json['first_name'] ?? '',
      lastname: json['last_name'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_users': id,
      'email': email,
      'first_name': firstname,
      'last_name': lastname,
      'avatar': avatar,
    };
  }
}
