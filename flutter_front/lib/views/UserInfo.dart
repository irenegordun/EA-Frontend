import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/login.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:provider/provider.dart';
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

Widget _buttons(BuildContext context, User user) {
  return Center(
      child: ButtonBar(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      ButtonTheme(
          minWidth: 200,
          child: ElevatedButton(
            onPressed: () {
              user = User(
                  name: "",
                  id: StorageAparcam().getId(),
                  password: "",
                  email: "",
                  newpassword: "",
                  points: 0,
                  myFavourites: [],
                  myParkings: [],
                  deleted: false);
              UserServices().deleteUsers(user);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Login()));
            },
            child: const Text('Delete account'),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  // Change your radius here
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
            ),
          )),
    ],
  ));
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

  var newpassword = "";
  var isLoaded = false;

  var user1 = User(
      name: "",
      id: StorageAparcam().getId(),
      password: "",
      email: "",
      points: 0,
      myFavourites: [],
      myParkings: [],
      deleted: false,
      newpassword: "");
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
                      user = User(
                          name: "",
                          id: StorageAparcam().getId(),
                          password: "",
                          email: email,
                          newpassword: "",
                          points: 0,
                          myFavourites: [],
                          myParkings: [],
                          deleted: false);
                      UserServices().updateUseremail(user);

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
                      user = User(
                          name: name,
                          id: StorageAparcam().getId(),
                          password: "",
                          email: "",
                          newpassword: "",
                          points: 0,
                          myFavourites: [],
                          myParkings: [],
                          deleted: false);
                      UserServices().updateUsername(user);

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
                      newpassword = editingController3.text;
                      user = User(
                        name: "",
                        id: StorageAparcam().getId(),
                        password: StorageAparcam().getpass(),
                        email: "",
                        newpassword: newpassword,
                        points: 0,
                        myFavourites: [],
                        myParkings: [],
                        deleted: false,
                      );
                      if (newpassword != "") {
                        UserServices().updateUserpass(user);
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserInfo()));
                    }),
              ),
              Container(child: _buttons(context, user)),
            ],
          ),
        ),
      );
}
