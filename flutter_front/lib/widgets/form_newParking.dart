import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import '../services/parkingServices.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_front/models/parking.dart';

enum Menu { car, moto }

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<FormWidget> {
  String _selectedMenu = '';

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: submit,
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context, rootNavigator: true).pop();
  }

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
            title: Text("Select the vehicle type",
                style: TextStyle(color: Colors.grey)),
            trailing: PopupMenuButton<Menu>(
                onSelected: (Menu item) {
                  setState(() {
                    _selectedMenu = item.name;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      const PopupMenuItem<Menu>(
                        value: Menu.car,
                        child: Text('Car'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.moto,
                        child: Text('Moto'),
                      ),
                    ]),
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

                  String formType = _selectedMenu.toString();
                  print(formType);

                  String formPrice = priceController.text.toString();
                  print(formPrice);
                  String formSize = sizeController.text.toString();
                  print(formSize);
                  String formDifficulty = difficultyController.text.toString();
                  print(formDifficulty);

                  if (formCountry != "" &&
                      formCity != "" &&
                      formStreet != "" &&
                      formNumber != "" &&
                      formSpot != "" &&
                      formType != "" &&
                      formPrice != "" &&
                      formSize != "" &&
                      formDifficulty != "") {
                    Parking p = Parking(
                        //user_id:  StorageAparcam().getId(),
                        // score: 0,
                        id: '',
                        country: formCountry,
                        city: formCity,
                        street: formStreet,
                        streetNumber: int.parse(formNumber),
                        spotNumber: int.parse(formSpot),
                        type: formType,
                        price: int.parse(formPrice),
                        size: formSize,
                        difficulty: int.parse(formDifficulty));

                    ParkingServices().createParking(p);
                    openDialog("Parking created.");
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ListParkings()));
                    });
                  } else {
                    openDialog(
                        "Please make sure all the flieds are filled before submit.");
                  }
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
