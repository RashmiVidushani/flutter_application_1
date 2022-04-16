class UserModel {
  String uid;
  String? username;
  String? bio;

  UserModel({required this.uid, this.username, this.bio});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      bio: map['bio'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'bio': bio,
    };
  }
}
