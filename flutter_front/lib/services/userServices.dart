import 'dart:convert';
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
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/deleted/$id');
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      return print("deleted");
    }
    return null;
  }

  Future<void> createUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/register');
    var userJS = json.encode(user.toJson());
    await client.post(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
  }

  Future<dynamic> updateUser(User user) async {
    var client = http.Client();
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/update/$id');
    var userJS = json.encode(user.toJson());
    var response = await client.put(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
    if (response.statusCode == 200) {
      var json = response.body;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/auth/login');
    var userJS = json.encode(user.LogintoJson());
    var response = await client.post(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
    if (response.statusCode == 200) {
      DetailsModel parametres = new DetailsModel(token: "", id: "");
      print("333333333333333333333333333333333333333333333333333333");
      print("response.body: " + response.body);
      final Map<String, dynamic> map = json.decode(response.body);
      DetailsModel det = detailsmodelfromJson(map);
      print("222222222222222222222222222222222222222222222222222222");
      StorageAparcam().addItemsToLocalStorage(det.token, det.id, user.password);
      print("111111111111111111111111111111111111111111111111111111");

      return true;
    } else {
      print("contrasenya no valida");
      return false;
    }
  }
}
