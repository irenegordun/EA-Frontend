import 'dart:convert';

List<User> listuserFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(Map<String, dynamic> str) => User.fromJson(str);

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      {
      //this.id = "", // non nullable but optional with a default value
      required this.name,
      required this.id,
      required this.password,
      required this.email,
      required this.newpassword});
  String id;
  String name;
  String password;
  String email;
  String newpassword;

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
        newpassword: "",
      );
  factory User.fromJsontoken(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        email: json["email"],
        newpassword: "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "email": email,
        "newpassword": newpassword,
      };

  Map<String, dynamic> LogintoJson() => {
        "password": password,
        "email": email,
      };
}
