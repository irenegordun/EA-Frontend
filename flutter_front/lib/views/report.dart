import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_front/models/report.dart';
import 'package:flutter_front/services/reportServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/views/UserInfo.dart';
import 'package:flutter_front/widgets/expandable.dart';

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

double sliderFont = 0.0;


final textController = TextEditingController();

class _MyReports extends State<MyReports> {
  bool _isVisible = false;
  bool _isVisible2 = false;
  bool _isVisible3 = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
      _isVisible2 = !_isVisible2;
      _isVisible3 = !_isVisible3;

    });
  }

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
            backgroundColor: Color.fromARGB(255, 230, 241, 248),
            shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(20.0)),
            title: Text ("APARCA'M", style: TextStyle(fontSize: 17)),
            content:Text(text,style: TextStyle(fontSize: 15)),
            actions: [
              TextButton(
                onPressed: submit,
                child: const Text('OK'),
              ),
            ],
          ),
        );

    return MaterialApp(
      home: Scaffold(
      drawer: const DrawerScreen(),
      floatingActionButton: const ExampleExpandableFab(),
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
          ListTile(
            trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                tooltip: 'Close',
                onPressed: () {
                  setState(() { _isVisible2 = !_isVisible2;});
                },
              ),
              tileColor: Color.fromARGB(255, 196, 202, 205),
              minVerticalPadding: 10.0,
              minLeadingWidth: 10.0,
              title: Text(
                  'Report',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * sliderFont/2)),
          ),
          ListTile(
            trailing: IconButton(
              icon: _isVisible == !_isVisible? Icon(Icons.abc_sharp) : Icon(Icons.arrow_forward_ios),
                tooltip: 'Close',
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                   });
                },
              ),
              tileColor: Color.fromARGB(255, 196, 202, 205),
              minVerticalPadding: 10.0,
              minLeadingWidth: 10.0,
              title: Text(
                  'Font size',
                  style: TextStyle( fontSize: MediaQuery.of(context).size.width * sliderFont/2,
          )),
          ),
          Visibility(
            visible: _isVisible2,
            child: Divider(),
          ),
          Visibility(
            visible: _isVisible,
            child: ListTile(
              title: Text("Size",
                style: TextStyle (
                  fontSize: MediaQuery.of(context).size.width * sliderFont/2,
                ),
              ),

            )),
          Visibility(
            visible: _isVisible,
            child: Slider(
              
                value: sliderFont,
                onChanged: (newFont) {
                  setState(() {
                    sliderFont = newFont;
                  });
                },
                min: 0.0,
                max: 0.5,
                divisions: 2,
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.blueGrey.shade100,
                thumbColor: Colors.blueGrey,
                label: "$sliderFont",
              )),






          Visibility(
            visible: _isVisible2,
            child: ListTile(
              trailing: IconButton(
                icon: const Icon(Icons.highlight_remove_sharp),
                tooltip: 'Close',
                onPressed: () {
                  setState(() {
                    _isVisible3 = !_isVisible3;
                  });
                },
              ),
              tileColor: Color.fromARGB(255, 196, 202, 205),
              minVerticalPadding: 10.0,
              minLeadingWidth: 10.0,
              title: const Text(
                  'Welcome to the report zone, here you can contact with the Service client to inform or report an issue',
                  style: TextStyle(fontSize: 16)),
          ),),
          Visibility(
            visible: _isVisible2,
            child: Divider(),
          ),
          
          Visibility(
          visible: _isVisible2,
          child: MultiSelectDialogField(
            items: _issueType.map((e) => MultiSelectItem(e, e.name)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {
              _selected = values;
            },
          ),
          ),

          Visibility(
            visible: _isVisible2,
            child: ListTile(
            title: TextFormField(
              maxLength: 20,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                hintText: 'Please write your issue',
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
                ),
                
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
          ),
          Visibility(
            visible: _isVisible2,
            child: ListTile(
            leading: Icon(Icons.balance),
            title: Text(
                'Select the gravity of the issue, where 3 is a big issue and 0 is a low issue',
                ),
          ),),
          
          Visibility(
            visible: _isVisible2,
            child: Slider(
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
          )),
          Visibility(
            visible: _isVisible2,
            child: Divider(),
          ),
          Visibility(
            visible: _isVisible2,
            child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
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
                        user: '',
                        type: typeSel,
                        text: textW,
                        level: difficulty);

                    ReportServices().createReport(p);
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ListParkings()));
                    });


                  } else {
                    openDialog("Please make sure that all fields are complete");
                  }

                  ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(65, 143, 74, 163));
                },
                child: const Text('Submit', )),
          ),),
          

      ])),
    ));
  }
}
