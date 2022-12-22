import 'package:flutter/material.dart';
import 'package:flutter_front/models/booking.dart';
import 'package:flutter_front/models/parking.dart';
import 'package:flutter_front/models/user.dart';
import 'package:flutter_front/services/bookingServices.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:provider/provider.dart';

import '../services/localStorage.dart';
import '../services/userServices.dart';
import '../widgets/drawer.dart';

class myBookings extends StatefulWidget {
  const myBookings({super.key});

  @override
  State<myBookings> createState() => _myBookingsState();
}

class _myBookingsState extends State<myBookings> {
  List<Booking> bookings = <Booking>[];

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
      myBookings: [],
      points: 0,
      deleted: false,
      newpassword: "");

  getData() async {
    final user = await UserServices().getOneUser(user1);
    if (user != null) {
      for (int i = 0; i < user.myBookings!.length; i++) {
        Booking b = Booking.fromJson(user.myBookings![i]);
        Parking? p = await ParkingServices().getOneParking(b.parking);
        b.parking = p!.street;
        if (b != null) {
          bookings.add(b);
        }
      }
      if (bookings != null) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    BookingServices _bookingprovider = Provider.of<BookingServices>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: new Center(
          child: new Text("My Bookings"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          //Row 2/2
          Expanded(
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color.fromARGB(255, 144, 180, 199),
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                    ),
                    title: Text(bookings[index].parking),
                    subtitle: Text(bookings[index].cost.toString()),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip: 'More Info',
                              onPressed: () {},
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
