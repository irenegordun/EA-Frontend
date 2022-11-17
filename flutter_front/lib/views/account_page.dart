import 'package:flutter/material.dart';
import 'package:flutter_front/widgets/drawer.dart';

import '../widgets/form.dart';

void main() => runApp(const AccountPage());

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const DrawerScreen(),
        appBar: AppBar(
          title: const Text("EA - Flutter Form"),
          backgroundColor: Colors.deepPurple[300], 
          ),
        body: const FormWidget(),
      ),
    );
  }
}

