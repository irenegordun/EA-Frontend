import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserServices extends ChangeNotifier {

  User _userData = new User(name:"",id: "",password:"",email: "");

  User get userData => _userData;

  void setUserData(User userData) {
    _userData = userData;
  }
  Future<List<User>?> getUsers() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return userFromJson(json);
    }
    return null;
  }

  Future<void> deleteUsers(String name) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/delete/$name');
    await client.delete(uri);
  }

  Future<void> createUser(User user) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/users/register');
    var userJS = json.encode(user.toJson());
    await client.post(uri,
        headers: {'content-type': 'application/json'}, body: userJS);
  }

  Future<bool> updateUser(User user) async {
    var client = http.Client();
    var name = user.name;
    var uri = Uri.parse('http://localhost:5432/api/users//update/$name');
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
}
