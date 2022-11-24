/*

const Parking = new Schema({
	user: { type: Schema.Types.ObjectId, ref: "User" },
    opinions: [{ type: Schema.Types.ObjectId, ref: "Opinion" }],
    email: String,
    country: String,
	city: String,
	street: String,
    streetNumber: Number,
	spotNumber: Number,
    type: String,
    price: Number,
    size: String,
    difficulty: Number,
    score: Number // S'actualitzen de manera interna
});

export default model('Parking', Parking);
 */

import 'dart:convert';

List<Parking> parkingFromJson(String str) =>
    List<Parking>.from(json.decode(str).map((x) => Parking.fromJson(x)));
//o no passa ve la x 
String parkingToJson(List<Parking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Parking {
  Parking({
    //required this.user,
    //required this.opinions,
    //required this.email,//no esta en la llista
    required this.country,
    required this.city,
    required this.street,
    //required this.streetNumber,
    required this.spotNumber,
    required this.type,
    required this.price,
    required this.size,
    required this.difficulty,
    //required this.score,
    required this.id,
  });

  //String user;
  //String email;
  String country;
  String city;
  String street;
  //int streetNumber; //NO QUADRA!! I MIRAR SCORE 
  int spotNumber;
  String type;
  int price;
  String size;
  int difficulty;
  //int score;
  String id; 

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
    id: json["_id"],
    //user: json["user"],
    //email: json["email"],
    country: json["country"],
    city: json["city"],
    street: json["street"],
    //streetNumber: json["streetNumber"], //!!
    spotNumber: json["spotNumber"],
    type: json["type"],
    price: json["price"],
    size: json["size"],
    difficulty: json["difficulty"],
    //score: json["score"], //!!! ACABAR D'ARREGLAR!!
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    //"email": email,
    "country": country,
    "city": city,
    "street": street,
    //"streetNumber": streetNumber, //!!
    "spotNumber": spotNumber,
    "type": type,
    "price": price,
    "size": size,
    "difficuty": difficulty,
    //"score": score, //!!
    
  };

}