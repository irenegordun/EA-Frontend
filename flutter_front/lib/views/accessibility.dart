import 'package:flutter/material.dart';


class Accessibility extends StatefulWidget {
  const Accessibility({super.key});
  @override
  State<Accessibility> createState() => _AccessibilitytState();
}

class _AccessibilitytState extends State<Accessibility> {
  bool _darkmode = false;
  bool _help = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accessibility'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
            //dark mode
              SwitchListTile(
                title: Text('Dark mode'),
                value: _darkmode,
                activeColor: Colors.blueGrey,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) {
                  setState(() {
                    _darkmode = value;
                  });
                },
                subtitle: Text('White --> dark per daltonics',style: TextStyle(
                  color: Colors.blueGrey[600],
                ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
            ),
            //lenguage
            ListTile(
              title: Text ("Lenguage"),
              subtitle: Text ("Select the lenguage"),
              trailing: 
                PopupMenuButton(
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Spanish"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("English"),
                  ),
                ];
              },
            )
            ), 
            //boto del panic
            SwitchListTile(
              title: Text("Botó del pànic",
                style: TextStyle(
                    color: Color.fromARGB(255, 239, 16, 16),
                    fontWeight: FontWeight.w800,
                    fontSize: 25
                ),
              ),
              value: _help,
                activeColor: Color.fromARGB(255, 250, 10, 10),
                inactiveTrackColor: Color.fromARGB(255, 221, 107, 107),
                onChanged: (bool value) {
                  setState(() {
                    _help = value;
                  });
                },
                subtitle: Text('blablabla',style: TextStyle(
                  color: Colors.blueGrey[600],
                ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
            ),
            
          ],
          ),
        ),
      ),
    );
  }
}
  
