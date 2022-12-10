import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/widgets/form_updateUser.dart';
import 'package:localstorage/localstorage.dart';

import '../models/user.dart';
import '../models/parking.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserServices extends ChangeNotifier {
  User _userData = new User(
    name: "",
    id: "",
    password: "",
    email: "",
  );

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

  Future<List<User>?> getOneUsers(User user) async {
    var client = http.Client();
    var id = user.id;
    var uri = Uri.parse('http://localhost:5432/api/users/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return listuserFromJson(json);
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

  Future<List<Parking>?> getParkingsOneU(Parking parkingData) async {
    var client = http.Client();
    var id = parkingData.id;
    var uri = Uri.parse('http://localhost:5432/api/users/myparkings/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return parkingFromJson(json);
    }
    return null;
  }

  Future<bool> loginUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/auth/login');
    var userJS = json.encode(user.LogintoJson());
    var response = await client.post(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
    if (response.statusCode == 200) {
      StorageAparcam().addItemsToLocalStorage('token', 'id');
      return true;
    } else {
      print("contrasenya no valida");
      return false;
    }
  }
}
