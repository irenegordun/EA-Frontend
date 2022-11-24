import 'dart:convert';

List<Parking> parkingFromJson(String str) =>
    List<Parking>.from(json.decode(str).map((x) => Parking.fromJson(x)));

String parkingToJson(List<Parking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Parking {
  Parking({
    required this.user,
    //required this.opinions,
    //required this.email,
    required this.country,
    required this.city,
    required this.street,
    required this.spotNumber,
    required this.type,
    required this.price,
    required this.size,
    required this.difficulty,
    required this.score,
    required this.id,
  });

  String user;
  //String email;
  String country;
  String city;
  String street;
  String spotNumber;
  String type;
  String price;
  String size;
  int difficulty;
  int score;
  String id;

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        id: json["_id"],
        user: json["user"],
        //email: json["email"],
        country: json["country"],
        city: json["city"],
        street: json["street"],
        spotNumber: json["spotNumber"],
        type: json["type"],
        price: json["price"],
        size: json["size"],
        difficulty: json["difficulty"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "country": country,
        "city": city,
        "street": street,
        "spotNumber": spotNumber,
        "type": type,
        "price": price,
        "size": size,
        "difficuty": difficulty,
        "score": score,
      };
}
