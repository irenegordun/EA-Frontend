import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import '../services/parkingServices.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FormWidget> {
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final spotController = TextEditingController();
  final typeController = TextEditingController();
  final priceController = TextEditingController();
  final sizeController = TextEditingController();
  final difficultyController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Permet accedir al form desde qualseevol lloc

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.public),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the country',
              ),
              controller: countryController,

              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              // onSaved: (value) {
              //   nameValue = value!;
              // },
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the city',
              ),
              controller: cityController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.signpost),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the street name',
              ),
              controller: streetController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.numbers_outlined),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the street number',
              ),
              controller: numberController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.numbers),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the parking spot number',
              ),
              controller: spotController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.car_rental_sharp),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the vehicle type',
              ),
              controller: typeController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.price_change),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the price',
              ),
              controller: priceController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.aspect_ratio),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the parking spot size',
              ),
              controller: sizeController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.balance),
            title: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the difficulty',
              ),
              controller: difficultyController,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: ElevatedButton(
                onPressed: () {
                  String formCountry = countryController.text.toString();
                  print(formCountry);
                  String formCity = cityController.text.toString();
                  print(formCity);
                  String formStreet = streetController.text.toString();
                  print(formStreet);
                  String formNumber = numberController.text.toString();
                  print(formNumber);
                  String formSpot = spotController.text.toString();
                  print(formSpot);
                  String formType = typeController.text.toString();
                  print(formType);
                  String formPrice = priceController.text.toString();
                  print(formPrice);
                  String formSize = sizeController.text.toString();
                  print(formSize);
                  String formDifficulty = difficultyController.text.toString();
                  print(formDifficulty);

                  const String secret = 'clavesecreta';

                  final jwt = JWT({
                    "user_id": "6346e161fe62edf290bd2ee1",
                    "email": "ferran@gmail.com",
                    "score": 0,
                    "country": formCountry,
                    "city": formCity,
                    "street": formStreet,
                    "streetNumber": formNumber,
                    "spotNumber": formSpot,
                    "type": formType,
                    "price": formPrice,
                    "size": formSize,
                    "difficulty": formDifficulty
                  });

                  // // TRY DECODE PER L'AIDA
                  // String tokenAida =
                  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNmNlNmUxMTE4Mjk4MDgwNzdkMGM1YiIsImVtYWlsIjoiYWx2YXJvQGdtYWlsLmNvbSIsImlhdCI6MTY2OTI4MTQ0MCwiZXhwIjoxNjY5MzY3ODQwfQ.nAASTme9N3WACld05OicwfKQ5-luHaTekr3q-aozAJM";
                  // try {
                  //   final jwtdecode =
                  //       JWT.verify(tokenAida, SecretKey('clavesecreta'));
                  //   print('PAYLOAD: ${jwtdecode.payload}');
                  //   final payload = jwtdecode.payload.toString();
                  //   print('PAYLOAD STRING: ${payload}');
                  //   //var info = json.decode(payload);
                  //   print('INFO UTIL: ');
                  // } on JWTError catch (ex) {
                  //   print(ex.message);
                  // }

                  var token = jwt.sign(SecretKey(secret));

                  ParkingServices().createParking(token);
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListParkings()));
                  });
                  ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(65, 143, 74, 163));
                },
                child: const Text('Submit')),
          )
        ],
      ),
    );
  }
}
