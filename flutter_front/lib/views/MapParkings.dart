import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:provider/provider.dart';

import '../models/parking.dart';
import '../widgets/drawer.dart';
import 'Filters.dart';
import 'ListParkings.dart';

//per sprint4

class MapParkings extends StatefulWidget {
  const MapParkings({super.key});

  @override
  State<MapParkings> createState() => _MapParkingsState();
}

class _MapParkingsState extends State<MapParkings> {
  List<Parking>? parkings;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    parkings = await ParkingServices().getParkings();
    if (parkings != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: new Center(
          child: new Text("A P A R C A ' M"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    color: Color.fromARGB(255, 227, 244, 248),
                    child: const Center(
                        child: Text("Calendar",
                            style: TextStyle(fontSize: 20.0))))),
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Filters()));
              },
              child: Container(
                color: Colors.blueGrey,
                child: const Center(
                    child: Text("Filters", style: TextStyle(fontSize: 20.0))),
              ),
            )),
          ])),
          Expanded(
              child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    height: 40,
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        child: const Text('List'),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blueGrey),
                        )))),
            Expanded(
                child: Container(
              height: 40,
              width: 50,
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Map'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  )),
            )),
          ])),
          Expanded(
              child: Row(children: <Widget>[
            Expanded(
                child: FlutterOpenStreetMap(
                    center: LatLong(5, 10),
                    onPicked: (pickedData) {
                      print(pickedData.latLong.latitude);
                      print(pickedData.latLong.longitude);
                      print(pickedData.address);
                    }))
          ]))
        ],
      ),
    );
  }
}
