import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/first_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_front/views/update_page.dart';
import 'package:flutter_front/views/parkingsList_MyUser.dart';

import '../models/user.dart';
import '../widgets/drawer.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserInfo> {
  deleteU(User user) async {
    var response = await UserServices().deleteUsers(user);
  }

  @override
  Widget build(BuildContext context) {
    UserServices _userprovider = Provider.of<UserServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: 300,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/icono-de-usuario-personas-vectoriales-vector-perfil-ilustraci%C3%B3n-persona-comercial-s%C3%ADmbolo-grupo-usuarios-masculino-195157776.jpg"),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Container(
              width: 400,
              height: 300,
              child: Column(
                children: <Widget>[
                  Text(_userprovider.userData.name),
                  Text(_userprovider.userData.email)
                ],
              ),
            ),
            Container(
              child: IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete',
                  onPressed: () {
                    deleteU(_userprovider.userData);
                  }),
            ),
            Container(
              child: IconButton(
                  icon: const Icon(Icons.update),
                  tooltip: 'Update',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UpdatePage()));
                  }),
            ),
            Container(
              child: IconButton(
                  icon: const Icon(Icons.emoji_transportation),
                  tooltip: 'MyParkings',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListMyParkings()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
