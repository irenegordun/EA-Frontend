import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/first_page.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../widgets/drawer.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

   _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserInfo> {
  

  @override
  Widget build(BuildContext context) {

  UserServices _userprovider = Provider.of<UserServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('Seminari 10 Fluter LLISTAT'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body:   Container(
          width: 900,
          height: 701,
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
                    margin: EdgeInsets.only(
                      top: 40, bottom: 10, left: 20, right: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://www.hola.com/imagenes/estar-bien/20180925130054/consejos-para-cuidar-a-un-gatito-recien-nacido-cs/0-601-526/cuidardgatito-t.jpg?filter=w600"),
                          fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Container(
                width: 100,
                height: 300,
                child: Column(
                  children: <Widget>[
                    Text(_userprovider.userData.name),
                    Text(_userprovider.userData.email)
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Volver"),
                ),
              )
            ],
          ),
        ),
      
    );
  }}