import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:localstorage/localstorage.dart';

import '../models/user.dart';
import '../models/parking.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

DetailsModel detailsmodelfromJson(Map<String, dynamic> prm) =>
    DetailsModel.fromJson(prm);

class DetailsModel {
  String token;
  String id;

  DetailsModel({required this.token, required this.id});

  factory DetailsModel.fromJson(Map<String, dynamic> json) =>
      DetailsModel(token: json['token'], id: json['id']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['token'] = this.token;
    data['id'] = this.id;

    return data;
  }
}

class UserServices extends ChangeNotifier {
  User _userData = User(
      name: "",
      id: "",
      password: "",
      email: "",
      myParkings: [],
      myFavourites: [],
      myBookings: [],
      deleted: false,
      points: 0,
      newpassword: "");

  User get userData => _userData;

  void setUserData(User userData) {
    _userData = userData;
  }

  Future<List<User>?> getUsers() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return listuserFromJson(json);
    }
    return null;
  }

  Future<User?> getOneUser(User user) async {
    var client = http.Client();
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/$id');
    var response = await client
        .get(uri, headers: {'x-access-token': StorageAparcam().getToken()});
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      User user = userFromJson(map);
      return user;
    }
    return null;
  }

  Future<void> deleteUsers(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/');
    var userJS = json.encode(user.toJson());
    var response = await client.delete(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: userJS);
    if (response.statusCode == 200) {
      return print("Account deleted");
    } else {
      return print("ERROR: can't delete the account");
    }
  }

  Future<void> createUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/');
    var userJS = json.encode(user.toJson());
    await client.post(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
  }

  Future<void> activateUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/activate');
    var userJS = json.encode(user.toJson());
    await client.put(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
  }

  Future<dynamic> updateUseremail(User user) async {
    var client = http.Client();
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/updateEmail');
    var userJS = json.encode(user.toJson());
    var response = await client.put(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: userJS);
    if (response.statusCode == 200) {
      var json = response.body;
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateUsername(User user) async {
    var client = http.Client();
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/updateName');
    var userJS = json.encode(user.toJson());
    var response = await client.put(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: userJS);
    if (response.statusCode == 200) {
      var json = response.body;
      return true;
    } else {
      return false;
    }
  }

  Future<int> checkemail(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/checkemail');
    var userJS = json.encode(user.toJson());
    var response = await client.put(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 2;
    }
  }

  Future<dynamic> updateUserpass(User user) async {
    var client = http.Client();
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/changepass');
    var userJS = json.encode(user.toJson());
    var response = await client.put(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: userJS);
    if (response.statusCode == 200) {
      var json = response.body;
      return true;
    } else {
      return false;
    }
  }

  Future<int> loginUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/auth/login');
    var userJS = json.encode(user.LogintoJson());
    var response = await client.post(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
    if (response.statusCode == 200) {
      DetailsModel parametres = new DetailsModel(token: "", id: "");

      final Map<String, dynamic> map = json.decode(response.body);
      DetailsModel det = detailsmodelfromJson(map);

      StorageAparcam().addItemsToLocalStorage(det.token, det.id, user.password);

      return 1;
    } else if (response.statusCode == 402) {
      return 2;
    } else {
      return 3;
    }
  }
}
