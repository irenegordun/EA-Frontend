import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/favorite_provider.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/services/userServices.dart';

import 'package:flutter_front/views/ParkingInfo.dart';
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

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _ListParkingsState();
}

class _ListParkingsState extends State<MyFavourites> {
  List<Parking> parkings = <Parking>[];
  var isLoaded = false;
  User? user;
  @override
  void initState() {
    super.initState();
    getData();
  }

  DeltoFav(Parking parking) async {
    UserServices().DelToFav(parking);
  }

  var user1 = User(
      id: StorageAparcam().getId(),
      name: "",
      password: "",
      email: "",
      myFavorites: [],
      myParkings: [],
      myBookings: [],
      points: 0,
      deleted: false,
      newpassword: "");

  getData() async {
    final user = await UserServices().getOneUser(user1);
    if (user != null) {
      for (int i = 0; i < user.myFavorites.length; i++) {
        Parking p = Parking.fromJson(user.myFavorites[i]);
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
    final provider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: new Center(
          child: new Text("My Favourites"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
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
          ])),

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
                      child: Image.asset('parking1.jpg'),
                    ),
                    title: Text(parkings[index].street),
                    subtitle: Text(parkings[index].city),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                icon: provider.isExist(parkings[index])
                                    ? const Icon(Icons.favorite_border)
                                    : const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                tooltip: 'Favorite',
                                onPressed: () {
                                  provider.toggleFavorite(parkings[index]);
                                },
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip: 'More Info',
                              onPressed: () {
                                _parkingprovider
                                    .setParkingData(parkings[index]);
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
