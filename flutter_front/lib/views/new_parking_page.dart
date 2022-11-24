import 'package:flutter/material.dart';

import '../widgets/form_parking.dart';

void main() => runApp(const NewParkingPage());

class NewParkingPage extends StatelessWidget {
  const NewParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Aparca'm - Create new parking spot"),
          backgroundColor: Colors.deepPurple[300],
        ),
        body: const FormWidget(),
      ),
    );
  }
}
