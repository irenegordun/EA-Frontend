import 'package:flutter/material.dart';
import 'package:flutter_front/views/first_page.dart';
import 'package:flutter_front/views/list_page.dart';
import 'package:flutter_front/views/account_page.dart';
import 'package:flutter_front/views/update_page.dart';

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
                  MaterialPageRoute(builder: (context) => const ListPage()));
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ListPage()));
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
            leading: const Icon(Icons.home),
            title: const Text(
              'List users',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ListPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'User Account: Login & Register',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AccountPage()));
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text(
              'Update',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UpdatePage()));
            },
          ),
        ],
      ),
    ))));
  }
}
