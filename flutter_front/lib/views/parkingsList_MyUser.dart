import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/user_info.dart';
import 'package:flutter_front/widgets/from_update.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../models/parking.dart';
import '../widgets/drawer.dart';
import 'first_page.dart';

class ListMyParkings extends StatefulWidget {
  const ListMyParkings({super.key});

  @override
  State<ListMyParkings> createState() => _MyParkingsPageState();
}

class _MyParkingsPageState extends State<ListMyParkings> {
  List<Parking>? parkings;
  var user = User(
    name: "",
    id: "",
    password: "",
    email: "",
  );
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    //user = await UserServices().getOneUsers(user);
    // parkings = await UserServices().getParkingsOneU(user);
    if (parkings != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserServices _myparkingprovider = Provider.of<UserServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('Els meus Parkings'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: parkings?.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.deepPurple[100],
              child: ListTile(
                title: Text(parkings![index].price),
                subtitle: Text(parkings![index].user),
                //falten altres camps
                trailing: SizedBox(
                    width: 120,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.home),
                            tooltip: 'Main',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const FirstPage()));
                            },
                          ),
                        ),
                        Expanded(
                            child: IconButton(
                          icon: const Icon(Icons.info_outline),
                          tooltip: 'More Info',
                          onPressed: () {
                            //_myparkingprovider.setParkingData(parkings![index]);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserInfo()));
                          },
                        )),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
