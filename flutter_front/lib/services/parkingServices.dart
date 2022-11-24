import 'package:flutter/material.dart';
import '../models/parking.dart';
import 'package:http/http.dart' as http;

class ParkingServices extends ChangeNotifier {
  Parking _parkingData = Parking(
      //email: "",
      country: "",
      city: "",
      street: "",
      streetNumber: "",
      spotNumber: "",
      type: "",
      price: "",
      size: "",
      difficulty: "",
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

  //Future<void> createParking(Parking parking) async {
  Future<void> createParking(String token) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/parkings/');
    //var parkingJS = json.encode(parking.toJson());
    await client.post(uri,
        //headers: {'content-type': 'application/json'}, body: parkingJS);
        headers: {'x-access-token': token});
  }
}
