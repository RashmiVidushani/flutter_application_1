/*import 'dart:convert';

List<UserModel> postFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromMap(x)));

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
}
*/
class UserModel {
  final String uid;
  final String username;
  final String phone;
  final String bio;

  UserModel(this.uid, this.username, this.phone, this.bio);
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(json['uid'], json['username'], json['phone'], json['bio']);
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['uid'], json['username'], json['phone'], json['bio']);
  }

  Map<String, dynamic> toJson() =>
      {'uid': uid, 'username': username, 'phone': phone, 'bio': bio};
}
