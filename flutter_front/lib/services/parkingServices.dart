import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/parking.dart';
import 'package:http/http.dart' as http;

class ParkingServices extends ChangeNotifier {
  Parking _parkingData = new Parking(country:"",city: "",street: "",spotNumber:0, type:"", price: 0, size: "", difficulty: 0, id:"");

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