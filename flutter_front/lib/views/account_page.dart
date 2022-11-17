import 'package:flutter/material.dart';

import '../widgets/form.dart';

void main() => runApp(const AccountPage());

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
          title: const Text("EA - Flutter Form"),
          backgroundColor: Colors.deepPurple[300], 
          ),
        body: const FormWidget(),
      ),
    );
  }
}

