import 'package:flutter/material.dart';
import 'package:flutter_front/dates/toDateTime.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_front/widgets/expandable.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter_front/services/favorite_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/parking.dart';
//import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';
import 'Filters.dart';
import 'MapParkings.dart';

class ListParkings extends StatefulWidget {
  const ListParkings({super.key});

  @override
  State<ListParkings> createState() => _ListParkingsState();
}

class _ListParkingsState extends State<ListParkings> {
  List<Parking>? parkings = [];
  var isLoaded = false;
  String firstdate = '';
  String lastdate = '';
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  Widget getDateRangePicker() {
    return SizedBox(
        height: 500,
        width: 500,
        child: Card(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
          onSelectionChanged: _onSelectionChanged,
          initialSelectedRange: PickerDateRange(
              DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now().add(const Duration(days: 3))),
        )));
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        firstdate = DateFormat('dd/MM/yyyy').format(args.value.startDate);
        lastdate = DateFormat('dd/MM/yyyy')
            .format(args.value.endDate ?? args.value.startDate);
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    // print(DateTime.now());
    // print(DateTime.now().toIso8601String());
    // print('${DateTime.now().toIso8601String()}Z');
    // const data = "2021-12-15T11:10:01.521Z";
    // DateTime dateTime = toDateTimeDart(data);
    // print('Date de mongo $data a datetime de DART $dateTime');
    // // MIRAR SI CALENDARI TORNA LA Z O NO
    // DateTime datetime2 = DateTime.parse('2021-12-15T11:10:01.521Z');
    // String data1 = toDateMongo(datetime2);
    // print('Datetime de dart $datetime2 a date de MONGO: $data1');
  }

  getData() async {
    if (StorageAparcam().getFiltered()) {
      var filters = {};
      filters["sortby"] = StorageAparcam().getSortby();
      filters["type"] = StorageAparcam().getType();
      filters["size"] = StorageAparcam().getDimensions();
      filters["smin"] = StorageAparcam().getminScore();
      filters["pmax"] = StorageAparcam().getmaxPrice();
      filters["pmin"] = StorageAparcam().getminPrice();
      filters["firstdate"] = StorageAparcam().getFirstdate();
      filters["lastdate"] = StorageAparcam().getLastdate();
      String body = json.encode(filters);
      parkings = await ParkingServices().getFilteredParkings(body);
    } else {
      parkings = await ParkingServices().getParkings();
    }
    if (parkings != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);
    final provider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: ExampleExpandableFab(),
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(children: <Widget>[
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(''),
                              content: Container(
                                height: 600,
                                width: 500,
                                child: Column(
                                  children: <Widget>[
                                    getDateRangePicker(),
                                    MaterialButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        StorageAparcam().setFilterDates(
                                            firstdate, lastdate);
                                        StorageAparcam().setFiltered(true);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ListParkings()));
                                      },
                                    )
                                  ],
                                ),
                              ));
                        });
                  },
                  child: Container(
                      color: const Color.fromARGB(255, 227, 244, 248),
                      child: const Center(
                          child: Text("Calendar",
                              style: TextStyle(fontSize: 20.0)))),
                )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Filters()));
              },
              child: Container(
                color: Colors.blueGrey,
                child: const Center(
                    child: Text("Filters", style: TextStyle(fontSize: 20.0))),
              ),
            )),
          ])),

          Expanded(
              child: Row(children: <Widget>[
            Expanded(
                child: Container(
                    height: 60,
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blueGrey),
                        ),
                        child: const Text('List')))),
            Expanded(
                child: Container(
                    height: 60,
                    width: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MapParkings()));
                        },
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blueGrey),
                        ),
                        child: const Text('Map')))),
          ])),
          Expanded(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      height: 35,
                      width: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          StorageAparcam().setSortby('none');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        icon: const Icon(Icons.cancel_sharp, size: 20.0),
                        label: Text('Sort by: ${StorageAparcam().getSortby()}'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 142, 162, 172)),
                      ))),
              Expanded(
                  child: Container(
                      height: 35,
                      width: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          StorageAparcam().setType('any');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        icon: const Icon(Icons.cancel_sharp, size: 20.0),
                        label: Text('Type: ${StorageAparcam().getType()}'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 142, 162, 172)),
                      ))),
              Expanded(
                  child: Container(
                      height: 35,
                      width: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          StorageAparcam().setDimensions('any');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        icon: const Icon(Icons.cancel_sharp, size: 20.0),
                        label:
                            Text('Size: ${StorageAparcam().getDimensions()}'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 142, 162, 172)),
                      ))),
              Expanded(
                  child: Container(
                      height: 35,
                      width: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          StorageAparcam().setminPrice(0);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        icon: const Icon(Icons.cancel_sharp, size: 20.0),
                        label: Text(
                            'Min price: ${StorageAparcam().getminPrice().toString()}'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 142, 162, 172)),
                      ))),
              Expanded(
                  child: Container(
                      height: 35,
                      width: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          StorageAparcam().setmaxPrice(999);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        icon: const Icon(Icons.cancel_sharp, size: 20.0),
                        label: Text(
                            'Max price: ${StorageAparcam().getmaxPrice().toString()}'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 142, 162, 172)),
                      ))),
              Expanded(
                  child: Container(
                      height: 35,
                      width: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          StorageAparcam().setminScore(0);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ListParkings()));
                        },
                        icon: const Icon(Icons.cancel_sharp, size: 20.0),
                        label: Text(
                            'Min score: ${StorageAparcam().getminScore().toString()}'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 142, 162, 172)),
                      ))),
            ],
          )),

          //Row 2/2
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: parkings?.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 144, 180, 199),
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset('parking1.jpg'),
                    ),
                    title: Text(
                        '${parkings![index].street}, ${parkings![index].city}'),
                    subtitle: Text(
                        'Price: ${parkings![index].price}/day || User score: ${parkings![index].score}'),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                icon: provider.isExist(parkings![index])
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border),
                                tooltip: 'Favorite',
                                onPressed: () {
                                  provider.toggleFavorite(parkings![index]);
                                },
                              ),
                            ),
                            Expanded(
                                child: IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip: 'More Info',
                              onPressed: () {
                                _parkingprovider
                                    .setParkingData(parkings![index]);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ParkingInfo()));
                              },
                            )),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(Icons.map_rounded),
                                onPressed: () {
                                  StorageAparcam().setMapLocation(
                                      parkings![index].latitude,
                                      parkings![index].longitude);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const MapParkings()));
                                },
                              ),
                            ),
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
