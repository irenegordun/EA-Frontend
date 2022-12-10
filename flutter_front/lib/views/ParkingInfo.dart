import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/accessibility.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../widgets/drawer.dart';

//enviar camps a backend i slider

class ParkingInfo extends StatefulWidget {
  const ParkingInfo({super.key});

  @override
  State<ParkingInfo> createState() => _ParkingInfoState();
}

class _ParkingInfoState extends State<ParkingInfo> {
  var isLoaded = false;

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
            icon: new Icon(Icons.close_outlined),
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
                title: Text('Direction',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(parking.street +
                    ' ' +
                    parking.streetNumber.toString() +
                    ', ' +
                    parking.city +
                    ', ' +
                    parking.country),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Price'),
                subtitle: Text(parking.price.toString() + ' €'),
                leading: Icon(
                  Icons.attach_money_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: Text('Type'),
                subtitle: Text(parking.type),
                leading: Icon(
                  Icons.two_wheeler,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: Text('Size'),
                subtitle: Text(parking.size),
                leading: Icon(
                  Icons.aspect_ratio_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: Text('Difficulty'),
                subtitle: Text(parking.difficulty.toString()),
                leading: Icon(
                  Icons.hardware_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Book'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
