import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_front/services/parkingServices.dart';

import '../models/user.dart';
import '../models/parking.dart';
import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';

class ListMyParkings extends StatefulWidget {
  const ListMyParkings({super.key});

  @override
  State<ListMyParkings> createState() => _MyParkingsPageState();
}

class _MyParkingsPageState extends State<ListMyParkings> {
  List<Parking>? parkings;
  var user = User(name: "", id: "", password: "", email: "", newpassword: "");
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

  deleteParking(Parking parking) async {
    var response = await ParkingServices().deleteParking(parking);
  }

  @override
  Widget build(BuildContext context) {
    UserServices _myparkingprovider = Provider.of<UserServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
      appBar: AppBar(
        title: const Text('Els meus Parkings'),
        backgroundColor: Colors.blueGrey,
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
              color: Color.fromARGB(255, 144, 180, 199),
              child: ListTile(
                title: Text(parkings![index].city),
                subtitle: Text(parkings![index].street),
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
                                  builder: (context) => const UserInfo()));
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
                        Expanded(
                          child: IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete Paking',
                              onPressed: () {
                                deleteParking(parkings![index]);
                              }),
                        ),
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
