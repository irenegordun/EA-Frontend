import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import '../services/parkingServices.dart';
import 'package:flutter_front/models/parking.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _MyStatefulWidgetState();
}

const List<String> typeList = <String>['car', 'moto', 'van'];
const List<String> sizeList = <String>['2x1', '5x2.5', '8x3.5'];
String dropdownTypeValue = typeList.first;
String dropdownSizeValue = sizeList.first;

class _MyStatefulWidgetState extends State<FormWidget> {
  String _selectedMenu = '';

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text('Ok'),
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
  final priceController = TextEditingController();
  final difficultyController = TextEditingController();
  double latitudeController = 0;
  double longitudeController = 0;
  String addressController = "";

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Permet accedir al form desde qualsevol lloc

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ListTile(
          //   leading: const Icon(Icons.public),
          //   title: TextFormField(
          //     decoration: const InputDecoration(
          //       hintText: 'Enter the country',
          //     ),
          //     controller: countryController,
          //     validator: (String? value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter some text';
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          // ListTile(
          //   leading: const Icon(Icons.location_city),
          //   title: TextFormField(
          //     decoration: const InputDecoration(
          //       hintText: 'Enter the city',
          //     ),
          //     controller: cityController,
          //     validator: (String? value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Please enter some  text';
          //       }
          //       return null;
          //     },
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.signpost),
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
            leading: const Icon(Icons.numbers_outlined),
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
            leading: const Icon(Icons.numbers),
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
              leading: const Icon(Icons.car_rental_sharp),
              title: const Text("Select the vehicle type",
                  style: TextStyle(color: Colors.grey)),
              trailing: DropdownButton<String>(
                value: dropdownTypeValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blueGrey),
                underline: Container(height: 2, color: Colors.blueGrey),
                onChanged: (String? value) {
                  setState(() {
                    dropdownTypeValue = value!;
                  });
                },
                items: typeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          ListTile(
            leading: const Icon(Icons.price_change),
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
              leading: const Icon(Icons.aspect_ratio),
              title: const Text("Select the dimensions of the parking spot",
                  style: TextStyle(color: Colors.grey)),
              trailing: DropdownButton<String>(
                value: dropdownSizeValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blueGrey),
                underline: Container(height: 2, color: Colors.blueGrey),
                onChanged: (String? value) {
                  setState(() {
                    dropdownSizeValue = value!;
                  });
                },
                items: sizeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          ListTile(
            leading: const Icon(Icons.balance),
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
          Expanded(
              child: FlutterOpenStreetMap(
                  center: LatLong((41.3948), (2.1596)),
                  showZoomButtons: true,
                  onPicked: (pickedData) {
                    latitudeController = pickedData.latLong.latitude.toDouble();
                    print(latitudeController);
                    longitudeController =
                        pickedData.latLong.longitude.toDouble();
                    print(longitudeController);
                    addressController = pickedData.address.toString();

                    print(addressController);
                    // var list = addressController.split(',');
                    // print("city " + list.last);
                    // list.removeLast();
                    // print("codigo postal " + list.last);
                    // list.removeLast();
                    // print(list);
                  })),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: ElevatedButton(
                onPressed: () {
                  var list = addressController.split(', ');
                  String formCountry =
                      list.last; //countryController.text.toString();
                  print(formCountry);
                  list.removeLast(); //city
                  list.removeLast(); //codigopostal
                  list.removeLast(); //Catalunya

                  String formCity = list.last; //cityController.text.toString();
                  print(formCity);
                  list.removeLast(); //Ciutat
                  String formStreet = streetController.text.toString();
                  print(formStreet);
                  String formNumber = numberController.text.toString();
                  print(formNumber);
                  String formSpot = spotController.text.toString();
                  print(formSpot);

                  String formType = dropdownTypeValue.toString();
                  print(formType);

                  String formPrice = priceController.text.toString();
                  print(formPrice);
                  String formSize = dropdownSizeValue.toString();
                  print(formSize);
                  String formDifficulty = difficultyController.text.toString();
                  print(formDifficulty);
                  String formLongitude = longitudeController.toString();
                  String formLatitude = latitudeController.toString();
                  print(formLatitude);
                  print(formLongitude);

                  if (formCountry.isNotEmpty &&
                      formCity.isNotEmpty &&
                      formStreet.isNotEmpty &&
                      formNumber.isNotEmpty &&
                      formSpot.isNotEmpty &&
                      formType.isNotEmpty &&
                      formPrice.isNotEmpty &&
                      formSize.isNotEmpty &&
                      formDifficulty.isNotEmpty) {
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
                        difficulty: int.parse(formDifficulty),
                        longitude: double.parse(formLongitude),
                        latitude: double.parse(formLatitude));

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
                      backgroundColor: const Color.fromARGB(65, 143, 74, 163));
                },
                child: const Text('Submit')),
          )
        ],
      ),
    );
  }
}
