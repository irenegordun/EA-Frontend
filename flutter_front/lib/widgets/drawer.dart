import 'package:flutter/material.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:flutter_front/views/accessibility.dart';
import 'package:flutter_front/views/myBookings.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/views/login.dart';
import 'package:flutter_front/views/MyFavourites.dart';
import 'package:flutter_front/views/chatbot.dart';
import 'package:flutter_front/widgets/expandable.dart';
import 'package:flutter_front/views/MyChats.dart';
import '../views/NewParking.dart';
import '../views/MyAgenda.dart';
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
          //MyAccount
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
          //List parkings
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

          //MyParkings
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

          //MyBookings
          ListTile(
            leading: const Icon(Icons.bookmark_outline),
            title: const Text('My bookings'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const myBookings()));
            },
          ),

          //MyFavourites
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text(
              'My favourites',
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyFavourites()));
            },
          ),
          //Create patking spot
          ListTile(
            leading: const Icon(Icons.add_circle_outline_outlined),
            title: const Text(
              'Create parking spot',
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NewParkingPage()));
            },
          ),
          //Chats
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text(
              'Chats',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePageMobile()));
            },
          ),
          //Report
          ListTile(
            leading: const Icon(Icons.highlight_remove_sharp),
            title: const Text(
              'Report',
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyReports()));
            },
          ),
          //ChatBot
          ListTile(
            leading: const Icon(Icons.room_service_outlined),
            title: const Text(
              'ChatBot',
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatBot()));
            },
          ),
          Divider(),
          //Logout
          ListTile(
            leading: const Icon(
              Icons.door_back_door,
              color: Colors.black,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              StorageAparcam().deleteToken();
              StorageAparcam().deleteId();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
        ],
      ),
    ))));
  }
}
