import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:flutter_front/views/myBookings.dart';

import '../views/NewParking.dart';
import '../views/report.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            child: Drawer(
                child: Container(
      color: const Color.fromARGB(255, 146, 166, 183),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                "A P A R C A 'M",
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          //Les meves dades
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text(
              'My account',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserInfo()));
            },
          ),
          //Llistat parquings
          ListTile(
            leading: const Icon(Icons.abc_sharp),
            title: const Text(
              'List parquings general',
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListParkings()));
            },
          ),

          //Els meus parquings
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text(
              'My parkings',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyParkings()));
            },
          ),

          //Les meves reserves
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: const Text('My bookings'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const myBookings()));
            },
          ),

          //Els meus preferits
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text(
              'My favourites',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.car_rental_rounded),
            title: const Text(
              'Create parking spot',
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NewParkingPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.highlight_remove_sharp),
            title: const Text(
              'Report some issue',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyReports()));
            },
          ),
        ],
      ),
    ))));
  }
}
