import 'package:flutter/material.dart';
import 'package:flutter_front/views/first_page.dart';
import 'package:flutter_front/views/list_page.dart';
import 'package:flutter_front/views/listParkings_page.dart';
import 'package:flutter_front/views/parkingsList_MyUser.dart';
import 'package:flutter_front/views/user_info.dart';

import '../views/new_parking_page.dart';

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
          //Main
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Main',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FirstPage()));
            },
          ),

          //Els meus parquings
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text(
              'My parkings',
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListMyParkings()));
            },
          ),

          //Les meves reserves
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: const Text(
              'My bookings',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ListPage()));
            },
          ),

          //Els meus preferits
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text(
              'My favourites',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ListPage()));
            },
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
        ],
      ),
    ))));
  }
}
