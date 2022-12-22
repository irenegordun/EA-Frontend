import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'package:flutter_front/views/accessibility.dart';
import 'package:flutter_front/widgets/drawer.dart';
import 'package:draggable_fab/draggable_fab.dart'; 

class AccessibilityButton extends StatefulWidget {
  const AccessibilityButton({super.key});
  
  @override
  State<AccessibilityButton> createState() => _AccessibilityButtonState();
}
  
  class _AccessibilityButtonState extends State<AccessibilityButton> {
  @override
  Widget build(BuildContext context) {
    return DraggableFab(
      child: FloatingActionButton(
        onPressed: (){
          setState(() {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const Accessibility()));
          });
        },
        child: Icon(Icons.accessibility_new_outlined),
      ),
      );
    
  }
}
  
  
  