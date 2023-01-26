import 'dart:convert';
import 'package:flutter_front/models/parking.dart';
import 'package:flutter_front/models/user.dart';

List<Booking> bookingsFromJson(String str) =>
    List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

Booking bookingFromJson(Map<String, dynamic> str) => Booking.fromJson(str);

String bookingToJson(List<Booking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  Booking({
    required this.parking,
    required this.customer,
    required this.arrival,
    required this.departure,
    required this.cost,
    required this.id,
    required this.owner,
  });

  String id;
  String parking;
  String customer;
  String arrival;
  String departure;
  int cost;
  String owner;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["_id"],
        arrival: json["arrival"],
        departure: json["departure"],
        parking: json["parking"],
        customer: json["customer"],
        cost: json["cost"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "arrival": arrival,
        "departure": departure,
        "parking": parking,
        "customer": customer,
        "cost": cost,
        "owner": owner,
      };
}
