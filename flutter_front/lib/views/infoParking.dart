import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../widgets/drawer.dart';


class ParkingInfo extends StatefulWidget {
  const ParkingInfo({super.key});

  @override
  State<ParkingInfo> createState() => _ParkingInfoState();
}

class _ParkingInfoState extends State<ParkingInfo> {
  static final showCard = true;
  
  @override
  Widget build(BuildContext context) {
    
  ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);

  return Scaffold(
    drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('INFO PARKING'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(child: showCard ? _buildCard() : _buildStack()),
     );   
  }

  Widget _buildCard() => SizedBox(
     
     //ParkingServices _parkingprovider = Provider.of<ParkingServices>(context),

      height: 330,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Direction',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('c/ ...'),
              leading: Icon(
                Icons.where_to_vote_outlined,
                color: Colors.blue[500],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('email',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              leading: Icon(
                Icons.email_outlined,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text('Price'),
              leading: Icon(
                Icons.attach_money_outlined,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text('Type'),
              leading: Icon(
                Icons.two_wheeler,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text('Size'),
              leading: Icon(
                Icons.aspect_ratio_outlined,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: Text('Difficulty'),
              leading: Icon(
                Icons.hardware_outlined,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );


    Widget _buildStack() => Stack(
      alignment: const Alignment(0.6, 0.6),
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/image1.jpg'),
          radius: 100,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          child: Text(
            'Aparcam',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
}