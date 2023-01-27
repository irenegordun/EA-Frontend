import 'package:flutter/material.dart';
import 'package:flutter_front/dates/toDateTime.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/views/UserInfo.dart';
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
import '../widgets/drawer.dart';
import 'Filters.dart';
import 'MapParkings.dart';

class ListParkings extends StatefulWidget {
  const ListParkings({super.key});

  @override
  State<ListParkings> createState() => _ListParkingsState();
}


class _ListParkingsState extends State<ListParkings> {
  bool _isVisible = true;
  List<Parking>? parkings = [];
  var isLoaded = false;
  String firstdate = '';
  String lastdate = '';
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

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
    Provider.of<FavoriteProvider>(context, listen: false).getFavorites();
    getData();
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
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.account_circle_outlined),
                tooltip: 'Account',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserInfo()));
                },
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(children: <Widget>[
            Expanded(
                flex: 7,
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
                                child:SingleChildScrollView(
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
                                )),
                              ));
                        });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                    child: Container(
                      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 239, 242, 243),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: const Icon(Icons.calendar_month_outlined),
                              onPressed: () {},
                            ),
                          ),
                          const Expanded(
                            flex: 6,
                            child:
                            Center( 
                              child: Text("Calendar",
                              style: TextStyle(fontSize: 18)),
                            ), 
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_drop_down_outlined),
                              onPressed: () {},
                            ),
                          ),
                        ]
                      ),
                    )
                  ),)),
            Expanded(
              flex: 3,
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Filters()));
              },
              child: Container(
                color: Colors.blueGrey,
                child: const Center(
                    child: Text("Filters", 
                    style: TextStyle(fontSize: 18.0, color: Color.fromARGB(255, 239, 242, 243)))),
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

          //Filters
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
                          setState(() {;
                          });
                        },
                        icon: const Icon(Icons.highlight_remove_sharp, size: 17.0),
                        label: const Text('Sort',
                        style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: StorageAparcam().getSortby() =='none' ? Color.fromARGB(255, 200, 203, 205) : Color.fromARGB(255, 142, 162, 172),)
                      )),
                  ),

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
                        icon: const Icon(Icons.highlight_remove_sharp, size: 17.0),
                        label: const Text('Type',
                        style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                           primary: StorageAparcam().getType() =='any' ? Color.fromARGB(255, 200, 203, 205) : Color.fromARGB(255, 142, 162, 172),

                          ),
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
                        icon: const Icon(Icons.highlight_remove_sharp, size: 17.0),
                        label: const Text('Size',
                        style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: StorageAparcam().getDimensions() =='any' ? Color.fromARGB(255, 200, 203, 205) : Color.fromARGB(255, 142, 162, 172),
                            ),
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
                        icon: const Icon(Icons.highlight_remove_sharp, size: 17.0),
                        label: const Text('Min price',
                        style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: StorageAparcam().getminPrice() ==0 ? Color.fromARGB(255, 200, 203, 205) : Color.fromARGB(255, 142, 162, 172),),
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
                        icon: const Icon(Icons.highlight_remove_sharp, size: 17.0),
                        label: const Text('Max price',
                        style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                           primary: StorageAparcam().getmaxPrice() == 1000 ? Color.fromARGB(255, 200, 203, 205) : Color.fromARGB(255, 142, 162, 172)),
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
                        icon: const Icon(Icons.highlight_remove_sharp, size: 17.0),
                        label: const Text('Min score',
                        style: TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: StorageAparcam().getminScore() == 0 ? Color.fromARGB(255, 200, 203, 205) : Color.fromARGB(255, 142, 162, 172)),
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
                        'Price: ${parkings![index].price} €/day'),
                    trailing: SizedBox(
                        width: 120,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                icon: provider.isExist(parkings![index])
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(Icons.favorite_border),
                                tooltip: 'Favourite',
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
