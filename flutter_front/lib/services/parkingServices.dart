import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class ParkingServices extends ChangeNotifier {

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
}