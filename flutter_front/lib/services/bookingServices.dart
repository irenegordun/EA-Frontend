import 'dart:convert';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter/material.dart';
import '../models/booking.dart';
import 'package:http/http.dart' as http;

import '../models/parking.dart';

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

class BookingServices extends ChangeNotifier {
  Booking _bookingData = Booking(
      arrival: "",
      departure: "",
      cost: 0,
      customer: "",
      parking: "",
      id: "",
      owner: "");

  Booking get bookingData => _bookingData;

  void setBookingData(Booking bookingData) {
    _bookingData = bookingData;
  }

  Future<void> deleteBooking(Booking booking) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/bookings/');
    var bookingJS = jsonEncode(booking.toJson());
    var response = await client.delete(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: bookingJS);
    if (response.statusCode == 200) {
      return print("deleted");
    }
    return null;
  }

  Future<void> createBooking(Booking booking) async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/bookings/');
    var bookingJS = json.encode(booking.toJson());
    var response = await client.post(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: bookingJS);
    if (response.statusCode == 200) {
      return print("Booking created");
    } else {
      return print("ERROR: can't create the booking");
    }
  }
}
