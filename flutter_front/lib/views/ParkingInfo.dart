import 'package:flutter/material.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';

class ParkingInfo extends StatefulWidget {
  const ParkingInfo({super.key});

  @override
  State<ParkingInfo> createState() => _ParkingInfoState();
}

class _ParkingInfoState extends State<ParkingInfo> {
  var isLoaded = false;

  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListParkings()));
            },
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: _buildCard(_parkingprovider.parkingData)),
    );
  }

  Widget _buildCard(Parking parking) => SizedBox(
        height: 600,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('Direction',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(
                    '${parking.street} ${parking.streetNumber}, ${parking.city}, ${parking.country}'),
                leading: const Icon(
                  Icons.where_to_vote_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Price'),
                subtitle: Text('${parking.price}/day'),
                leading: const Icon(
                  Icons.attach_money_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Type'),
                subtitle: Text(parking.type),
                leading: const Icon(
                  Icons.two_wheeler,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Size'),
                subtitle: Text(parking.size),
                leading: const Icon(
                  Icons.aspect_ratio_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Difficulty'),
                subtitle: Text(parking.difficulty.toString()),
                leading: const Icon(
                  Icons.hardware_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  ),
                  child: const Text('Book'),
                ),
              ),
            ],
          ),
        ),
      );
}
