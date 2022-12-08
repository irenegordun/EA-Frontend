import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:provider/provider.dart';

import '../models/parking.dart';
//import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';

class ListParkings extends StatefulWidget {
  const ListParkings({super.key});

  @override
  State<ListParkings> createState() => _ListParkingsState();
  
}

class _ListParkingsState extends State<ListParkings> {
  List<Parking>? parkings;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }
  getData() async {
    parkings = await ParkingServices().getParkings();
    if (parkings != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);

    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: new Center(
          child: new Text("A P A R C A ' M"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          //Card(
              /*
              //color: Color.fromARGB(255, 0, 0, 0),
              child: Wrap(
                spacing: 3,
                children: [ 
                  Chip(
                    label: Text("Moto"),
                    onDeleted: (){},
                  ),
                  Chip(
                    label: Text("Cotxe"),
                    onDeleted: (){},
                  ),
                ],)
              */
          //),
           Row(
            children: [
              Expanded(
                child: 
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('List'),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  )
                )
              ),
              Expanded(
                child: 
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Map'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  )
                )
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Open Date Picker'),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Open Date Picker'),
                  ),
                
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
          itemCount: parkings?.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 144, 180, 199),
              child: ListTile(
                leading: Container(
                  width: 80,
                  height: 80,
                  child: Image.asset(
                      'parking1.jpg'),
                ),
                
                title: Text(parkings![index].street),
                subtitle: Text(parkings![index].city),
                trailing: SizedBox(
                    width: 120,

                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Icons.favorite_border_outlined),
                            tooltip: 'Add to favourites',
                            onPressed: () {
                            },
                          ),
                        ),
                        Expanded(
                            child: IconButton(
                          icon: const Icon(Icons.info_outline),
                          tooltip: 'More Info',
                          onPressed: () {
                             _parkingprovider.setParkingData(parkings![index]);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ParkingInfo()));
                          },
                        )),   
                      ],
                    )),
              ),
            );
          },
        ),
            
        ),
        ],      
      ),
    );
  }
}