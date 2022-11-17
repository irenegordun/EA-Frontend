import 'package:flutter/material.dart';

import '../widgets/drawer.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  List<String> values=[
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
    'assets/image4.jpg',
    'assets/image5.jpg',
    'assets/image6.jpg',
    'assets/image7.jpg',
    'assets/image8.jpg',
    'assets/image9.jpg',
    'assets/image10.jpg',
    'assets/image11.jpg',
    'assets/image12.jpg',
    'assets/image13.jpg',
    'assets/image14.jpg',
    'assets/image15.jpg',
    'assets/image16.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: const Text('Seminari 10 Flutter'),
        backgroundColor: Colors.deepPurple[300], 
      ),
      body: Column(
        children: <Widget>[ 
         Card(
              color: Colors.deepPurple[100],
              child: const ListTile(
                title: Text('Imagineu que és una app de reserva de restaurants' + "\n" + 'En la pagina principal es podria veure la galeria dels restaurants'),
              ),
         ),
        Expanded(child: 
        GridView.builder(
          itemCount: 16,
          itemBuilder: (context, index){
            return Card(
              elevation: 10, 
              child: Center(
                child: Image.asset(values[index]),
              ),
            );
          },
          gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        ),
        ),
        ],
      ),
    );
  }
}
