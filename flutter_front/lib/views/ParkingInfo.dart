import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/services/bookingServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../models/booking.dart';

class ParkingInfo extends StatefulWidget {
  const ParkingInfo({super.key});

  @override
  State<ParkingInfo> createState() => _ParkingInfoState();
}

class _ParkingInfoState extends State<ParkingInfo> {
  var isLoaded = false;
  DateTime? firstdate;

  BookingParking(Booking booking) async {
    BookingServices().createBooking(booking);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ListParkings()));
  }

  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListParkings()));
            },
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: _buildCard(_parkingprovider.parkingData)),
    );
  }

  Widget _buildCard(Parking parking) => SizedBox(
        height: 600,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('Direction',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(
                    '${parking.street} ${parking.streetNumber}, ${parking.city}, ${parking.country}'),
                leading: const Icon(
                  Icons.where_to_vote_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Price'),
                subtitle: Text('${parking.price}/day'),
                leading: const Icon(
                  Icons.attach_money_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Type'),
                subtitle: Text(parking.type),
                leading: const Icon(
                  Icons.two_wheeler,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Size'),
                subtitle: Text(parking.size),
                leading: const Icon(
                  Icons.aspect_ratio_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Difficulty'),
                subtitle: Text(parking.difficulty.toString()),
                leading: const Icon(
                  Icons.hardware_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              TextButton(
                child: Text("Book"),
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromARGB(255, 39, 51, 58),
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 20))
                      .then((PickedDate1) {
                    if (PickedDate1 == null) {
                      return;
                    }
                    firstdate = PickedDate1;
                  });
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(DateTime.now().year + 20))
                      .then((PickedDate2) {
                    if (PickedDate2 == null) {
                      return;
                    }
                    Booking booking1 = Booking(
                        arrival: firstdate.toString(),
                        departure: PickedDate2.toString(),
                        cost: parking.price,
                        customer: StorageAparcam().getId(),
                        parking: parking.id,
                        id: "",
                        owner: "");
                    BookingParking(booking1);
                  });
                },
              )
            ],
          ),
        ),
      );
}