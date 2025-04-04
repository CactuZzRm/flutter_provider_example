class User {
  final int id;
  final String? username;

  User({
    required this.id,
    required this.username,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        username = json['username'] as String;
}
