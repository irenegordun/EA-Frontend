import 'dart:convert';
import '../models/parking.dart';

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
      required this.newpassword,
      required this.email,
      required this.myParkings,
      required this.points,
      required this.deleted,
      required this.myFavourites,
      required this.myBookings});

  String id;
  String name;
  String password;
  String newpassword;
  String email;

  List<dynamic> myParkings;
  int points;
  bool deleted;
  List<dynamic>? myFavourites;
  List<dynamic>? myBookings;

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
        newpassword: "",
        email: json["email"],
        myParkings: json["myParkings"],
        points: json["points"],
        myFavourites: json["myFavourites"],
        myBookings: json["myBookings"],
        deleted: json["deleted"],
      );
  factory User.fromJsontoken(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        password: json["password"],
        newpassword: "",
        email: json["email"],
        myParkings: json["myParkings"],
        points: json["points"],
        myFavourites: json["myFavourites"],
        myBookings: json["myBookings"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "newpassword": newpassword,
        "email": email,
        "myParkings": myParkings,
        "points": points,
        "myFavourites": myFavourites,
        "myBookings": myBookings,
        "deleted": deleted,
      };

  Map<String, dynamic> LogintoJson() => {
        "password": password,
        "email": email,
      };
}
