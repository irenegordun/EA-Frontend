import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/views/MyParkings.dart';
import 'package:flutter_front/views/ParkingInfo.dart';
import 'package:flutter_front/widgets/buttonAccessibility.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/parking.dart';
import '../widgets/drawer.dart';
import 'Filters.dart';
import 'ListParkings.dart';
import 'package:zoom_widget/zoom_widget.dart';

class MapParkings extends StatefulWidget {
  const MapParkings({super.key});

  @override
  State<MapParkings> createState() => _MapParkingsState();
}

class _MapParkingsState extends State<MapParkings> {
  List<Parking>? parkings = [];

  var isLoaded = false;

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
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Row(children: <Widget>[
                Expanded(
                    child: Container(
                        color: Color.fromARGB(255, 227, 244, 248),
                        child: const Center(
                            child: Text("Calendar",
                                style: TextStyle(fontSize: 20.0))))),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Filters()));
                  },
                  child: Container(
                    color: Colors.blueGrey,
                    child: const Center(
                        child:
                            Text("Filters", style: TextStyle(fontSize: 20.0))),
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
