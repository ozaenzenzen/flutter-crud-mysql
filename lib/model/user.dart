class User {
  String? username;
  String? password;
  String? level;

  User({
    this.username,
    this.password,
    this.level,
  });

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
      username: object['username'].toString(),
      password: object['password'].toString(),
      level: object['level'].toString(),
    );
  }
}
