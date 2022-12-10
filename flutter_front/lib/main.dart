import 'package:flutter/material.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/views/Filters.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/Login.dart';
import 'package:flutter_front/views/NewParking.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:flutter_front/views/accessibility.dart';
import 'package:flutter_front/widgets/button.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_front/widgets/form_user.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserServices()),
        ChangeNotifierProvider(create: (_) => ParkingServices()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
    );
  }
}
