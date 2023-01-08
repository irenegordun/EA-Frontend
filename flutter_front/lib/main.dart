import 'package:flutter/material.dart';
import 'package:flutter_front/services/bookingServices.dart';
import 'package:flutter_front/services/userServices.dart';

import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/login.dart';
import 'package:flutter_front/views/MapParkings.dart';
import 'package:flutter_front/views/NewParking.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/views/UserInfo.dart';

import 'package:flutter_front/views/register.dart';
import 'package:flutter_front/views/accessibility.dart';
import 'package:flutter_front/widgets/calendar.dart';

import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/language_constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserServices()),
        ChangeNotifierProvider(create: (_) => ParkingServices()),
        ChangeNotifierProvider(create: (_) => BookingServices()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Login(),
      locale: _locale,
    );
  }
}
