import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:provider/provider.dart';

import '../models/parking.dart';
//import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';

class ListParkings extends StatefulWidget {
  const ListParkings({super.key});

  @override
  State<ListParkings> createState() => _ListParkingsState();
}

class _ListParkingsState extends State<ListParkings> {
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
        title: const Text('LLISTAT PARKINGS'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        
        child: ListView.builder(
          itemCount: parkings?.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 144, 180, 199),
              child: ListTile(
                title: Text(parkings![index].city),
                subtitle: Text(parkings![index].street),
                //falten altres camps
                trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.home),
                            tooltip: 'Main',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ParkingInfo()));
                            },
                          ),
                        ),
                        Expanded(
                            child: IconButton(
                          icon: const Icon(Icons.info_outline),
                          tooltip: 'More Info',
                          onPressed: () {
                             _parkingprovider.setParkingData(parkings![index]);
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
    );
  }
}