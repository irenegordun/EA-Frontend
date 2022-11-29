import 'package:flutter/material.dart';

import 'package:flutter_front/views/accessibility.dart';
import 'package:flutter_front/widgets/drawer.dart';
import 'package:draggable_fab/draggable_fab.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      
      floatingActionButton: DraggableFab(
            child: FloatingActionButton(
              onPressed: (){
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Accessibility()));
                });
              },
              child: Icon(Icons.accessibility_new_outlined),
            ),
          ),
        
    );
    
  }
}
