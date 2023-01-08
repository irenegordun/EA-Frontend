import 'dart:convert';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter/material.dart';
import '../models/parking.dart';
import 'package:http/http.dart' as http;

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

class ParkingServices extends ChangeNotifier {
  Parking _parkingData = Parking(
    //email: "",
    country: "",
    city: "",
    street: "",
    streetNumber: 0,
    spotNumber: 0,
    type: "",
    price: 0,
    size: "",
    difficulty: 0,
    score: 0,
    id: "",
    latitude: 0,
    longitude: 0,
    user: "",
    range: "",
  );

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
      return parkingsFromJson(json);
    }
    return null;
  }

  Future<List<Parking>?> getFilteredParkings(String filters) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/filter');
    var response = await client.post(uri,
        headers: {'content-type': 'application/json'}, body: filters);
    if (response.statusCode == 200) {
      var json = response.body;
      return parkingsFromJson(json);
    }
    return null;
  }

  Future<void> deleteParking(Parking parking) async {
    var client = http.Client();
    var id = parking.id;
    var uri = Uri.parse('http://localhost:5432/api/parkings/');
    var parkingJS = jsonEncode(parking.toJson());
    var response = await client.delete(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: parkingJS);
    if (response.statusCode == 200) {
      return print("deleted");
    }
    return null;
  }

  Future<void> createParking(Parking parking) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/');
    var parkingJS = json.encode(parking.toJson());
    var response = await client.post(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: parkingJS);
    if (response.statusCode == 200) {
      return print("Parking created");
    } else {
      return print("ERROR: can't create the parkings spot");
    }
  }

  Future<dynamic> updatePriceParking(Parking parking) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/update/');
    var parkingJS = jsonEncode(parking.toJson());
    var response = await client.put(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken(),
        },
        body: parkingJS);
    if (response.statusCode == 200) {
      var json = response.body;
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> updateAddressParking(Parking parking) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/updateAddress/');
    var parkingJS = jsonEncode(parking.toJson());
    var response = await client.put(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: parkingJS);
    if (response.statusCode == 200) {
      var json = response.body;
      return true;
    } else {
      return false;
    }
  }

  Future<Parking?> getOneParking(String id) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/$id');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      Parking parking = parkingFromJson(map);
      return parking;
    }
    return null;
  }

  Future<Parking?> getByStreet(String street) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/byStreet/$street');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body);
      Parking parking = parkingFromJson(map);
      return parking;
    }
    return null;
  }
}
