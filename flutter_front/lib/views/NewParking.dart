import 'package:flutter/material.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_front/widgets/drawer.dart';

import '../widgets/form_newParking.dart';

void main() => runApp(const NewParkingPage());

class NewParkingPage extends StatelessWidget {
  const NewParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const DrawerScreen(),
        floatingActionButton :const AccessibilityButton(),

        appBar: AppBar(
          title: const Text("Aparca'm"),
          backgroundColor: Colors.blueGrey,
        ),
        body: const FormWidget(),
      ),
    );
  }
}
