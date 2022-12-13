import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/services/parkingServices.dart';

import 'package:flutter_front/views/MyParkings.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../widgets/drawer.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:localstorage/localstorage.dart';

class MyParkingInfo extends StatefulWidget {
  const MyParkingInfo({super.key});

  @override
  State<MyParkingInfo> createState() => _MyParkingInfoState();
}

class _MyParkingInfoState extends State<MyParkingInfo> {
  var isLoaded = false;
  deleteOneParking(Parking parking) async {
    var response = await ParkingServices().deleteParking(parking);
  }

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

  TextEditingController editingController1 = TextEditingController();
  TextEditingController editingController2 = TextEditingController();
  TextEditingController editingController3 = TextEditingController();
  TextEditingController editingController4 = TextEditingController();
  TextEditingController editingController5 = TextEditingController();
  TextEditingController editingController6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('INFO PARKING'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: _buildCard(_parkingprovider.parkingData)),
    );
  }

  Widget _buildCard(Parking parking) => SizedBox(
        height: 900,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text('Country',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                    controller: editingController1,
                    decoration: InputDecoration(hintText: parking.country)),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      parking.country = editingController1.text;
                      parking = Parking(
                          country: parking.country,
                          city: parking.city,
                          street: parking.street,
                          streetNumber: parking.streetNumber,
                          spotNumber: parking.spotNumber,
                          type: "",
                          price: 0,
                          size: "",
                          difficulty: 0,
                          id: parking.id);
                      if (parking.country != "") {
                        ParkingServices().updateAddressParking(parking);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyParkingInfo()));
                      } else {
                        openDialog("Country field is empty!");
                      }
                    }),
              ),
              ListTile(
                title:
                    Text('City', style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                    controller: editingController2,
                    decoration: InputDecoration(hintText: parking.city)),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      parking.city = editingController2.text;
                      parking = Parking(
                          country: parking.country,
                          city: parking.city,
                          street: parking.street,
                          streetNumber: parking.streetNumber,
                          spotNumber: parking.spotNumber,
                          type: parking.type,
                          price: parking.price,
                          size: parking.size,
                          difficulty: parking.difficulty,
                          id: parking.id);
                      if (parking.city != "") {
                        ParkingServices().updateAddressParking(parking);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyParkingInfo()));
                      } else {
                        openDialog("City field is empty!");
                      }
                    }),
              ),
              ListTile(
                title: Text('Street',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                    controller: editingController3,
                    decoration: InputDecoration(hintText: parking.street)),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      parking.street = editingController3.text;
                      parking = Parking(
                          country: parking.country,
                          city: parking.city,
                          street: parking.street,
                          streetNumber: parking.streetNumber,
                          spotNumber: parking.spotNumber,
                          type: parking.type,
                          price: parking.price,
                          size: parking.size,
                          difficulty: parking.difficulty,
                          id: parking.id);
                      if (parking.street != "") {
                        ParkingServices().updateAddressParking(parking);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyParkingInfo()));
                      } else {
                        openDialog("Street field is empty!");
                      }
                    }),
              ),
              ListTile(
                title: Text('Street Number',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                    controller: editingController4,
                    decoration: InputDecoration(
                        hintText: parking.streetNumber.toString())),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      if (editingController4.text != "") {
                        parking.streetNumber =
                            int.parse(editingController4.text);
                        parking = Parking(
                            country: parking.country,
                            city: parking.city,
                            street: parking.street,
                            streetNumber: parking.streetNumber,
                            spotNumber: parking.spotNumber,
                            type: parking.type,
                            price: parking.price,
                            size: parking.size,
                            difficulty: parking.difficulty,
                            id: parking.id);
                        ParkingServices().updateAddressParking(parking);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyParkingInfo()));
                      } else {
                        openDialog("Street number field is empty!");
                      }
                    }),
              ),
              ListTile(
                title: Text('Spot Number',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                    controller: editingController5,
                    decoration: InputDecoration(
                        hintText: parking.spotNumber.toString())),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      if (editingController5.text != "") {
                        parking.spotNumber = int.parse(editingController5.text);
                        parking = Parking(
                            country: parking.country,
                            city: parking.city,
                            street: parking.street,
                            streetNumber: parking.streetNumber,
                            spotNumber: parking.spotNumber,
                            type: parking.type,
                            price: parking.price,
                            size: parking.size,
                            difficulty: parking.difficulty,
                            id: parking.id);
                        ParkingServices().updateAddressParking(parking);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyParkingInfo()));
                      } else {
                        openDialog("Spot number field is empty!");
                      }
                    }),
              ),
              ListTile(
                title: Text('Type'),
                subtitle: Text(parking.type),
                leading: Icon(
                  Icons.two_wheeler,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: Text('Price',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                    controller: editingController6,
                    decoration:
                        InputDecoration(hintText: parking.price.toString())),
                leading: Icon(
                  Icons.where_to_vote_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      if (editingController6.text != "") {
                        parking.price = int.parse(editingController6.text);
                        parking = Parking(
                            country: parking.country,
                            city: parking.city,
                            street: parking.street,
                            streetNumber: parking.streetNumber,
                            spotNumber: parking.spotNumber,
                            type: parking.type,
                            price: parking.price,
                            size: parking.size,
                            difficulty: parking.difficulty,
                            id: parking.id);
                        ParkingServices().updatePriceParking(parking);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MyParkingInfo()));
                      } else {
                        openDialog("Price field is empty!");
                      }
                    }),
              ),
              ListTile(
                title: Text('Size'),
                subtitle: Text(parking.size),
                leading: Icon(
                  Icons.aspect_ratio_outlined,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: Text('Difficulty'),
                subtitle: Text(parking.difficulty.toString()),
                leading: Icon(
                  Icons.aspect_ratio_outlined,
                  color: Colors.blue[500],
                ),
              ),
              Expanded(
                child: IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete',
                    onPressed: () {
                      deleteOneParking(parking);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyParkings()));
                    }),
              ),
            ],
          ),
        ),
      );
}
