// To parse this JSON data, douserFromJson
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> listuserFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(Map<String, dynamic> str) => User.fromJson(str);

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

  void setemail(String email) {
    this.email = email;
  }

  void setname(String name) {
    this.name = name;
  }

  void setpass(String pass) {
    this.password = pass;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        password: "",
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
