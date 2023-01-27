import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import '../services/parkingServices.dart';
import 'package:flutter_front/models/parking.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _MyStatefulWidgetState();
}

final List<String> typeList = <String>['car', 'moto', 'van'];
final List<String> sizeList = <String>['2x1', '5x2.5', '8x3.5'];

String dropdownTypeValue = typeList.first;
String dropdownSizeValue = sizeList.first;
String? selectedValue;
double sliderDif = 0.0;

class _MyStatefulWidgetState extends State<FormWidget> {
  final ScrollController controller = ScrollController(initialScrollOffset: 50.0);
  
  Widget getDateRangePicker() {
    return SizedBox(
        height: 500,
        width: 500,
        child: Card(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
          onSelectionChanged: _onSelectionChanged,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        )));
  }

  String _selectedMenu = '';

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 230, 241, 248),
            shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0)),
            title: Text ("APARCA'M", style: TextStyle(fontSize: 17)),
            content: Text(text, style: TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text('OK'),
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

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Permet accedir al form desde qualsevol lloc

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
      return SizedBox(
        width: constraints.maxWidth,
      child: Scrollbar(
        
        thickness: 20.0,
        thumbVisibility: true,
        controller: controller,
        child:Form(
          
          key: _formKey,
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.signpost),
              title: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter the street name',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 126, 126, 126)),
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
                  hintStyle: TextStyle(color: Color.fromARGB(255, 126, 126, 126)),
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
                  hintStyle: TextStyle(color: Color.fromARGB(255, 126, 126, 126)),
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
                  hintStyle: TextStyle(color: Color.fromARGB(255, 126, 126, 126)),
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
          

            const ListTile(
              leading: const Icon(Icons.balance),
              title: Text('Choose the difficulty',
                  style: TextStyle(fontWeight: FontWeight.w500, color: Color.fromARGB(255, 126, 126, 126))),
            ),
            Slider(
              value: sliderDif,
              onChanged: (newScore) {
                setState(() {
                  sliderDif = newScore;
                });
              },
              min: 0.0,
              max: 10.0,
              divisions: 10,
              activeColor: Colors.blueGrey,
              inactiveColor: Colors.blueGrey.shade100,
              thumbColor: Colors.blueGrey,
              label: "$sliderDif",
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text("Enter the availability",
                  style: TextStyle(color: Color.fromARGB(255, 126, 126, 126))),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                tooltip: 'Select the availability',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(''),
                            content: Container(
                              height: 600,
                              width: 500,
                              child: Column(
                                children: <Widget>[
                                  getDateRangePicker(),
                                  MaterialButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            ));
                      });
                },
              ),
            ),
            Expanded(
                child: FlutterOpenStreetMap(
                    center: LatLong((41.3948), (2.1596)),
                    showZoomButtons: true,
                    onPicked: (pickedData) {
                      latitudeController = pickedData.latLong.latitude.toDouble();
                      longitudeController =
                          pickedData.latLong.longitude.toDouble();
                      addressController = pickedData.address.toString();

                    })),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                  ),
                  onPressed: () {
                    String formStreet = streetController.text.toString();
                    String formNumber = numberController.text.toString();
                    String formSpot = spotController.text.toString();
                    String formType = dropdownTypeValue.toString();
                    String formPrice = priceController.text.toString();
                    String formSize = dropdownSizeValue.toString();

                    if (addressController.isNotEmpty &&
                        formStreet.isNotEmpty &&
                        formNumber.isNotEmpty &&
                        formSpot.isNotEmpty &&
                        formType.isNotEmpty &&
                        formPrice.isNotEmpty &&
                        formSize.isNotEmpty) {
                      var list = addressController.split(', ');
                      String formCountry =
                      list.last; //countryController.text.toString();
                      list.removeLast(); //city
                      list.removeLast(); //codigopostal
                      list.removeLast(); //Catalunya

                      String formCity =
                          list.last; //cityController.text.toString();
                      list.removeLast();
                      Parking p = Parking(
                          score: 0,
                          id: '',
                          user: '',
                          country: formCountry,
                          city: formCity,
                          street: formStreet,
                          streetNumber: int.parse(formNumber),
                          spotNumber: int.parse(formSpot),
                          type: formType,
                          price: int.parse(formPrice),
                          size: formSize,
                          difficulty: double.parse(sliderDif.toString()),
                          longitude: longitudeController,
                          latitude: latitudeController,
                          range: _range);

                      ParkingServices().createParking(p);
                      openDialog("Parking created.");
                      setState(() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ListParkings()));
                      });
                    } else if (formStreet.isEmpty ||
                        formNumber.isEmpty ||
                        formSpot.isEmpty ||
                        formType.isEmpty ||
                        formPrice.isEmpty ||
                        formSize.isEmpty) {
                      openDialog(
                          "Please make sure all the flieds are filled before submit.");
                    } else if (addressController.isEmpty) {
                      openDialog(
                          "Please select the localization of your parking and click 'set the current location' once it is correct");
                    } else {
                      openDialog(
                          "Ops something went wrong check if it is something missing");
                    }
                    ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(65, 143, 74, 163));
                  },
                  child: const Text('Submit')),
            )
          ],
        ),
        ),
        
    ));

      });
  }
}
