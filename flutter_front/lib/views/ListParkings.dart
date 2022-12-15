import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:provider/provider.dart';

import '../models/parking.dart';
//import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';
import 'Filters.dart';
import 'MapParkings.dart';

//millorar visualment

class ListParkings extends StatefulWidget {
  const ListParkings({super.key});

  @override
  State<ListParkings> createState() => _ListParkingsState();
}

class _ListParkingsState extends State<ListParkings> {
  List<Parking>? parkings = [];
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
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
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
                        onPressed: () {},
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
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MapParkings()));
                        },
                        child: const Text('Map'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blueGrey),
                        )))),
          ])),

          //Row 2/2
          Expanded(
            child: ListView.builder(
              itemCount: parkings?.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromARGB(255, 144, 180, 199),
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset('parking1.jpg'),
                    ),
                    title: Text(parkings![index].street),
                    subtitle: Text(parkings![index].city),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                icon:
                                    const Icon(Icons.favorite_border_outlined),
                                tooltip: 'Add to favourites',
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip: 'More Info',
                              onPressed: () {
                                _parkingprovider
                                    .setParkingData(parkings![index]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ParkingInfo()));
                              },
                            )),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
