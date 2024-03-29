import 'package:flutter/material.dart';
import 'package:flutter_front/models/booking.dart';
import 'package:flutter_front/models/parking.dart';
import 'package:flutter_front/models/user.dart';
import 'package:flutter_front/services/bookingServices.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/Agenda2.dart';
import 'package:flutter_front/views/MyAgenda.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:flutter_front/views/myBookingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_front/widgets/expandable.dart';
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
  bool seguro = false;

  User? user;
  @override
  void initState() {
    super.initState();
    getData();
  }

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

  Future yousure() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Are you sure you want to cancel this booking?"),
          actions: [
            TextButton(
              onPressed: sure,
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: submit,
              child: const Text('No'),
            ),
          ],
        ),
      );

  void sure() {
    seguro = true;
    Navigator.of(context, rootNavigator: true).pop();
  }

  var user1 = User(
      id: StorageAparcam().getId(),
      name: "",
      password: "",
      email: "",
      myFavorites: [],
      chats: [],
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
        var user2 = User(
            id: b.owner,
            name: "",
            password: "",
            email: "",
            myFavorites: [],
            chats: [],
            myParkings: [],
            myBookings: [],
            points: 0,
            deleted: false,
            newpassword: "");
        User? u = await UserServices().getOneUser(user2);
        b.parking = p!.street;
        b.owner = u!.name;
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
      floatingActionButton: const ExampleExpandableFab(),
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          
          Padding(
              padding: const EdgeInsets.all(8.0),            
              child: IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                tooltip: 'Agenda',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DynamicEvent()));
                },
              )),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                tooltip: 'Account',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserInfo()));
                },
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          //Row 2/2
          Expanded(
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 144, 180, 199),
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset('parking1.jpg'),
                    ),
                    title: Text(bookings[index].parking),
                    subtitle: Text(bookings[index].cost.toString()),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              tooltip: 'Chat with the owner',
                              onPressed: () {},
                            )),
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip: 'More Info',
                              onPressed: () {
                                _bookingprovider
                                    .setBookingData(bookings[index]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const MyBookingInfo()));
                              },
                            )),
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.delete_sharp),
                              tooltip: 'Cancel booking',
                              onPressed: () async {
                                await yousure();
                                if (seguro) {
                                  print(bookings[index].id);
                                  await BookingServices()
                                      .deleteBooking(bookings[index]);
                                  openDialog(
                                      'Booking deleted, the owner will be informed');
                                } else {
                                  openDialog('Action undone');
                                }
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const myBookings()));
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
