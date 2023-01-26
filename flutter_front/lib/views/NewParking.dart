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
      scrollBehavior: const MaterialScrollBehavior()
      .copyWith(scrollbars: false),
      home: Scaffold(
        drawer: const DrawerScreen(),
        appBar: AppBar(
          title: const Center(
            child: Text("A P A R C A ' M"),
        ),
          backgroundColor: Colors.blueGrey,
        ),
        body: const FormWidget(),
      ),
    );
  }
}
