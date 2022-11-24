// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> listuserFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(String str) => User.fromJson(str as Map<String, dynamic>);

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    //this.id = "", // non nullable but optional with a default value
    required this.name,
    required this.id,
    required this.password,
    required this.email,
  });
  String id;
  String name;
  String password;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
      );
  factory User.fromJsontoken(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "email": email,
      };

  Map<String, dynamic> LogintoJson() => {
        "password": password,
        "email": email,
      };
}
