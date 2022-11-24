import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/parking.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class ParkingServices extends ChangeNotifier {
  Parking _parkingData = new Parking(
      user: "",
      country: "",
      city: "",
      street: "",
      spotNumber: "",
      type: "",
      price: "",
      size: "",
      difficulty: 0,
      score: 0,
      id: "");

  Parking get parkingData => _parkingData;

  void setParkingData(Parking parkingData) {
    _parkingData = parkingData;
  }

  Future<List<Parking>?> getParkings() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return parkingFromJson(json);
    }
    return null;
  }
}
