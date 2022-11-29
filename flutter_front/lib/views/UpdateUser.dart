import 'package:flutter/material.dart';
import 'package:flutter_front/widgets/drawer.dart';
import '../models/user.dart';
import '../widgets/form_updateUser.dart';

void main() => runApp(const UpdatePage());

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: const DrawerScreen(),
        appBar: AppBar(
            title: const Text("Update User"),
            backgroundColor: Colors.blueGrey),
        body: const FormWidgetUpdate(), //cridar
      ),
    );
  }
}
