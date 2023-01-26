import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/parking.dart';
import '../widgets/drawer.dart';
import 'Filters.dart';
import 'ListParkings.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MapParkings extends StatefulWidget {
  const MapParkings({super.key});

  @override
  State<MapParkings> createState() => _MapParkingsState();
}

class _MapParkingsState extends State<MapParkings> {
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
  List<Parking>? parkings = [];
  var isLoaded = false;
  String firstdate = '';
  String lastdate = '';
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';



  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    parkings = await ParkingServices().getParkings();
    if (parkings != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);
    List<LatLng> latLngList = [];
    int i = 0;
    while (parkings?.length != i) {
      latLngList.add(LatLng(
          parkings![i].latitude.toDouble(), parkings![1].longitude.toDouble()));
      i = i + 1;
    }
    double longitude = 2.1596;
    double latitude = 41.3948;
    if (StorageAparcam().getLatitude() != 0 ||
        StorageAparcam().getLongitude() != 0) {
      latitude = StorageAparcam().getLatitude();
      longitude = StorageAparcam().getLongitude();
    } else {
      longitude = 2.1596;
      latitude = 41.3948;
    }
    print(latLngList);

    List<Marker> _markers = latLngList
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) => Icon(
                Icons.pin_drop,
                size: 60,
                color: Colors.blueAccent,
              ),
            ))
        .toList();
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: new Center(
          child: new Text("A P A R C A ' M"),
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
                    decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                    child: Container(
                      margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 239, 242, 243),
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
              flex: 1,
              child: Row(children: <Widget>[
                Expanded(
                    child: Container(
                        height: 60,
                        width: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ListParkings()));
                            },
                            child: const Text('List'),
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.blueGrey),
                            )))),
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
                      child: const Text('Map')),
                )),
              ])),
          Expanded(
              flex: 9,
              child: Row(children: <Widget>[
                Expanded(
                    child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(latitude, longitude),
                          zoom: 15,
                          plugins: [MarkerClusterPlugin()],
                          interactiveFlags:
                              InteractiveFlag.all - InteractiveFlag.rotate,
                        ),
                        layers: [
                      TileLayerOptions(
                        minZoom: 1,
                        maxZoom: 20,
                        backgroundColor: Colors.black,
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerClusterLayerOptions(
                        maxClusterRadius: 190,
                        disableClusteringAtZoom: 16,
                        size: Size(50, 50),
                        fitBoundsOptions: FitBoundsOptions(
                          padding: EdgeInsets.all(50),
                        ),
                        markers: _markers,
                        polygonOptions: PolygonOptions(
                            borderColor: Colors.blueAccent,
                            color: Colors.black12,
                            borderStrokeWidth: 3),
                        builder: (context, markers) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.orange, shape: BoxShape.circle),
                            child: Text('${markers.length}'),
                          );
                        },
                      ),
                    ]))
              ]))
        ],
      ),
    );
  }
}

//https://techblog.geekyants.com/implementing-flutter-maps-with-osm
//https://github.com/fleaflet/flutter_map/blob/master/example/lib/pages/many_markers.dart
