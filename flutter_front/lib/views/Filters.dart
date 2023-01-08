import 'package:flutter/material.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/views/ListParkings.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

const List<String> sizeList = <String>['any', '2x1', '5x2.5', '8x3.5'];
const List<String> typeList = <String>['any', 'car', 'moto', 'van'];
const List<String> sortList = <String>['score', 'price'];
String dropdownTypeValue = typeList.first;
String dropdownSizeValue = sizeList.first;
String dropdownSortValue = sortList.first;

double sliderScore = 0.0;
double _startValue = 0.0;
double _endValue = 100.0;

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('F i l t e r s'),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                  title: const Text('Sort by',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  trailing: DropdownButton<String>(
                    value: dropdownSortValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.blueGrey),
                    underline: Container(height: 2, color: Colors.blueGrey),
                    onChanged: (String? newvalue) {
                      setState(() {
                        dropdownSortValue = newvalue!;
                      });
                    },
                    items:
                        sortList.map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                  )),
              const Divider(),
              const ListTile(
                title: Text('Minimum score',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Slider(
                value: sliderScore,
                onChanged: (newScore) {
                  setState(() {
                    sliderScore = newScore;
                  });
                },
                min: 0.0,
                max: 10.0,
                divisions: 5,
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.blueGrey.shade100,
                thumbColor: Colors.blueGrey,
                label: "$sliderScore",
              ),
              const Divider(),
              const ListTile(
                title: Text('Price range',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              RangeSlider(
                values: RangeValues(_startValue, _endValue),
                onChanged: (newValues) {
                  setState(() {
                    _startValue = newValues.start;
                    _endValue = newValues.end;
                  });
                },
                min: 0.0,
                max: 100.0,
                divisions: 5,
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.blueGrey.shade100,
                labels: RangeLabels(
                  _startValue.round().toString(),
                  _endValue.round().toString(),
                ),
              ),
              const Divider(),
              ListTile(
                  title: const Text('Type of vehicle',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  trailing: DropdownButton<String>(
                    value: dropdownTypeValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.blueGrey),
                    underline: Container(height: 2, color: Colors.blueGrey),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownTypeValue = value!;
                      });
                    },
                    items:
                        typeList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              const Divider(),
              ListTile(
                  title: const Text('Dimensions',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  trailing: DropdownButton<String>(
                    value: dropdownSizeValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.blueGrey),
                    underline: Container(height: 2, color: Colors.blueGrey),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownSizeValue = value!;
                      });
                    },
                    items:
                        sizeList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: ElevatedButton(
                  onPressed: () {
                    StorageAparcam().addFiltersToLocalStorage(
                        true,
                        dropdownSortValue,
                        sliderScore,
                        _startValue,
                        _endValue,
                        dropdownTypeValue,
                        dropdownSizeValue);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListParkings()));
                  },
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  ),
                  child: const Text('View the results'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
