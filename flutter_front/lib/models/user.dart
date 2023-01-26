import 'dart:convert';
import '../models/parking.dart';
import '../models/chat.dart';

List<User> listuserFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

User userFromJson(Map<String, dynamic> str) => User.fromJson(str);

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

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
      required this.myFavorites,
      required List<Chat> chats,
      required this.myBookings});

  String id;
  String name;
  String password;
  String newpassword;
  String email;

  List<dynamic> myParkings;
  int points;
  bool deleted;
  List<dynamic> myFavorites;
  List<dynamic>? myBookings;
  List<Chat>? chats;

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
        chats: [],
        myFavorites: json["myFavorites"],
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
        myFavorites: json["myFavorites"],
        myBookings: json["myBookings"],
        deleted: json["deleted"],
        chats: [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "password": password,
        "newpassword": newpassword,
        "email": email,
        "myParkings": myParkings,
        "points": points,
        "chats": chats,
        "myFavorites": myFavorites,
        "myBookings": myBookings,
        "deleted": deleted,
      };

  Map<String, dynamic> LogintoJson() => {
        "password": password,
        "email": email,
      };

  Map<String, dynamic> GoogleLogintoJson() => {
        "name": name,
        "email": email,
        "password": password,
      };
}
