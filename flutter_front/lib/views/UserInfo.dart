import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_front/widgets/form_updateUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter_front/views/UpdateUser.dart';
import 'package:flutter_front/views/MyParkings.dart';

import '../models/user.dart';
import '../widgets/drawer.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_front/services/localStorage.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User? user;
  deleteU(User user) async {
    var response = await UserServices().deleteUsers(user);
  }

  @override
  void initState() {
    super.initState();
    print("StorageAparcam: " + StorageAparcam().getId());
    getData();
  }

  var email;
  var name;
  var password = "*******";
  var isLoaded = false;
  var user1 = User(
    name: "",
    id: StorageAparcam().getId(),
    password: "",
    email: "",
  );
  getData() async {
    user = await UserServices().getOneUser(user1);
    if (user != null) {
      setState(() {
        isLoaded = true;
        email = user!.email.toString();
        name = user!.name.toString();
        print("email: " +
            user!.email.toString() +
            "name: " +
            user!.name.toString() +
            "pass: " +
            user!.password.toString());
      });
    }
  }

  TextEditingController editingController1 = TextEditingController();
  TextEditingController editingController2 = TextEditingController();
  TextEditingController editingController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserServices _userprovider = Provider.of<UserServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: _buildCard(_userprovider.userData)),
    );
  }

  Widget _buildCard(User user) => SizedBox(
        height: 600,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text('email',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: TextFormField(
                  controller: editingController1,
                  decoration: InputDecoration(hintText: email),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      email = editingController1.text;
                      user = new User(
                          name: name,
                          id: StorageAparcam().getId(),
                          password: password,
                          email: email);
                      UserServices().updateUser(user);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
              ListTile(
                title: Text('Name'),
                subtitle: TextFormField(
                  controller: editingController2,
                  decoration: InputDecoration(hintText: name),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      name = editingController2.text;
                      user = new User(
                          name: name,
                          id: StorageAparcam().getId(),
                          password: password,
                          email: email);
                      UserServices().updateUser(user);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
              ListTile(
                title: Text('Password'),
                subtitle: TextFormField(
                  controller: editingController3,
                  decoration: InputDecoration(hintText: password),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.password,
                  color: Colors.blue[500],
                ),
                trailing: TextButton(
                    child: Text("Editar"),
                    onPressed: () {
                      password = editingController3.text;
                      user = new User(
                          name: name,
                          id: StorageAparcam().getId(),
                          password: password,
                          email: email);
                      UserServices().updateUser(user);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
            ],
          ),
        ),
      );
}
