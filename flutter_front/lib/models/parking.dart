import 'dart:convert';

List<Parking> parkingsFromJson(String str) =>
    List<Parking>.from(json.decode(str).map((x) => Parking.fromJson(x)));

Parking parkingFromJson(Map<String, dynamic> str) => Parking.fromJson(str);

String parkingToJson(List<Parking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Parking {
  Parking(
      {
      //required this.opinions,
      required this.country,
      required this.city,
      required this.street,
      required this.streetNumber,
      required this.spotNumber,
      required this.type,
      required this.price,
      required this.size,
      required this.difficulty,
      required this.score,
      required this.id,
      required this.user,
      required this.latitude,
      required this.longitude,
      required this.range
      });

  String country;
  String city;
  String street;
  int streetNumber;
  int spotNumber;
  String type;
  int price;
  String size;
  double difficulty;
  int score;
  String id;
  double latitude;
  double longitude;
  String user;
  String range;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        id: json["_id"],
        country: json["country"],
        city: json["city"],
        street: json["street"],
        streetNumber: json["streetNumber"],
        spotNumber: json["spotNumber"],
        type: json["type"],
        price: json["price"],
        size: json["size"],
        difficulty: json["difficulty"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        score: json["score"],
        user: json["user"],
        range: json["range"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country": country,
        "city": city,
        "street": street,
        "streetNumber": streetNumber,
        "spotNumber": spotNumber,
        "type": type,
        "price": price,
        "size": size,
        "difficulty": difficulty,
        "latitude": latitude,
        "longitude": longitude,
        //"score": score,
        "score": score,
        "user": user,
        "range": range,
      };
}
