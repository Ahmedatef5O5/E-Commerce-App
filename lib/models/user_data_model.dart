class UserDataModel {
  final String id;
  final String username;
  final String email;
  final String createdAt;

  UserDataModel({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
  });

  // convert model to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'createdAt': createdAt,
    };
  }

  // convert Map to model
  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
