import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/models/report.dart';
import 'package:flutter_front/services/reportServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/UserInfo.dart';

import '../services/localStorage.dart';
import '../widgets/buttonAccessibility.dart';
import '../widgets/drawer.dart';
import 'dart:html';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';

class Issue {
  final int id;
  final String name;

  Issue({
    required this.id,
    required this.name,
  });
}

class MyReports extends StatefulWidget {
  const MyReports({super.key});

  @override
  State<MyReports> createState() => _MyReports();
}

final textController = TextEditingController();

class _MyReports extends State<MyReports> {
  double sliderDif = 0.0;
  static List<Issue> _issueType = [
    Issue(id: 1, name: "Car"),
    Issue(id: 2, name: "User"),
    Issue(id: 3, name: "Other")
  ];

  var isLoaded = false;
  List<Issue> _selected = [];
  List<Report>? reports = [];
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
    reports = await ReportServices().getReports();
    if (reports != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context, rootNavigator: true).pop();
    }

    Future openDialog(String text) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text('Ok'),
              ),
            ],
          ),
        );

    return MaterialApp(
        home: Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const AccessibilityButton(),
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
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
        const ListTile(
          leading: const Icon(Icons.highlight_remove_sharp),
          title: Text(
              'Welcome to the report zone, here you can contact with the Service client to inform or report an issue',
              style: TextStyle(fontWeight: FontWeight.w900)),
        ),
        MultiSelectDialogField(
          items: _issueType.map((e) => MultiSelectItem(e, e.name)).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            _selected = values;
          },
        ),
        ListTile(
          leading: const Icon(Icons.access_alarms_rounded),
          title: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Please write your issue',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 40),
            ),
            controller: textController,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
        const ListTile(
          leading: const Icon(Icons.balance),
          title: Text(
              'Select the gravity of the issue, where 3 is a big issue and 0 is a low issue',
              style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        Slider(
          value: sliderDif,
          onChanged: (newScore) {
            setState(() {
              sliderDif = newScore;
            });
          },
          min: 0.0,
          max: 3.0,
          divisions: 3,
          activeColor: Colors.blueGrey,
          inactiveColor: Colors.blueGrey.shade100,
          thumbColor: Colors.blueGrey,
          label: "$sliderDif",
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty && _selected.isNotEmpty) {
                  String textW = textController.text.toString();
                  int difficulty = int.parse(sliderDif.toString());
                  String now = new DateTime.now().toString();
                  print(now);
                  String typeSel = "";
                  while (_selected.isNotEmpty) {
                    typeSel = typeSel + "/" + _selected.last.name.toString();
                    _selected.removeLast();
                  }
                  print(typeSel);
                  Report p = Report(
                      id: StorageAparcam().getId(),
                      //id: '',
                      user: '',
                      type: typeSel,
                      text: textW,
                      level: difficulty);

                  ReportServices().createReport(p);
                  //openDialog("Parking created.");
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListParkings()));
                  });

                  //String formatter =
                  //DateFormat('yMd').format(now); // 28/03/2020
                } else {
                  openDialog("Please make sure that all fields are complete");
                }

                ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(65, 143, 74, 163));
              },
              child: const Text('Submit')),
        ),
        // ListView.builder(
        //   itemCount: reports?.length,
        //   itemBuilder: (context, index) {
        //     return Card(
        //       color: const Color.fromARGB(255, 144, 180, 199),
        //       child: ListTile(
        //         leading: Container(
        //           width: 100,
        //           height: 100,
        //           //child: Image.asset('parking1.jpg'),
        //         ),
        //         title: Text('${reports![index].type}'),
        //         subtitle: Text(
        //             'Level: ${reports![index].level}'), //|| Issue: ${reports![index].text}'),
        //       ),
        //     );
        //   },
        // )
      ])),
    ));
  }
}
//difficulty: double.parse(sliderDif.toString()),