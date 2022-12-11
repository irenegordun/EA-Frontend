import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/services/userServices.dart';

import 'package:flutter_front/views/MyParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';

import 'package:flutter_front/views/UserInfo.dart';

import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/parking.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_front/services/localStorage.dart';
//import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';

//millorar visualment

class MyParkings extends StatefulWidget {
  const MyParkings({super.key});

  @override
  State<MyParkings> createState() => _MyParkingsState();
}


class _MyParkingsState extends State<MyParkings> {
  List<Parking> parkings = <Parking>[];

  var isLoaded = false;

  User? user;
  @override
  void initState() {
    super.initState();
    getData();
  }

  var user1 = User(
      id: StorageAparcam().getId(),
      name: "",
      password: "",
      email: "",
      myFavourites: [],
      myParkings: [],
      points: 0,
      deleted: false,
      newpassword: "");

  getData() async {
    final user = await UserServices().getOneUser(user1);
    if (user != null) {
      for (int i = 0; i < user.myParkings.length; i++) {
        Parking p = Parking.fromJson(user.myParkings[i]);
        if (p != null) {
          parkings.add(p);
        }
      }
      if (parkings != null) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: new Center(
          child: new Text("Els Meus Parkings"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          //Row 2/2
          Expanded(
            child: ListView.builder(
              itemCount: parkings.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromARGB(255, 144, 180, 199),
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                    ),
                    title: Text(parkings[index].street),
                    subtitle: Text(parkings[index].city),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip: 'More Info',
                              onPressed: () {
                                _parkingprovider
                                    .setParkingData(parkings[index]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const MyParkingInfo()));
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
