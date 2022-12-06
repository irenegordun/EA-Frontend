import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: new Text('F i l t e r s'),
        ),
        backgroundColor: Colors.blueGrey,
      ),

      body: Center(
        child: Card(
          color: Colors.white,
          child: Column(
          children: [
            ListTile(
              title: Text('Ordenar por',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text("Ordenar por:"),
              trailing: 
                PopupMenuButton(
                  itemBuilder: (context){
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("Score (from lowest to highest)"),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("Price(from lowest to highest)"),
                      ),
                    ];
                  },
                )
              
            ),
            Divider(),
            ListTile(
              title: Text('Minimum score',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              
            ),
            Divider(),
            ListTile(
              title: Text('Maximum score',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              
            ),
            Divider(),
            ListTile(
              title: Text('Maximum price',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              /*trailing: 
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),*/
            ),
            Divider(),
            ListTile(
              title: Text('Type of vehicle',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: 
                PopupMenuButton(
                  itemBuilder: (context){
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("20x30x50"),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("20x50x80"),
                      ),
                    ];
                  },
                )
            ),
            Divider(),
            ListTile(
              title: Text('Dimensions',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: 
                PopupMenuButton(
                  itemBuilder: (context){
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("Car"),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("Motorbike"),
                      ),
                    ];
                  },
                )
            ),
             ListTile(
                contentPadding: EdgeInsets.zero,
                title: ElevatedButton(
                  onPressed: () {},
                  child: const Text('View the results'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  ),
                ),
                
             )
          ],
        ),
        ),
        
      ),
    );
  }
}
