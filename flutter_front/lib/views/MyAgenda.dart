import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/views/myBookings.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class MyAgenda extends StatefulWidget {
  const MyAgenda({super.key});

  @override
  State<MyAgenda> createState() => _MyAgendaState();
}

class _MyAgendaState extends State<MyAgenda> {
  
  //final eventNameController = TextEditingController();
  //final fromController = TextEditingController();
  //final toController = TextEditingController();


  DateTime? _selectedDate;
  
  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                //Navigator.pop(context);
                return;
              } else {
                print(titleController.text);
                print(descpController.text);

                setState(() {
                  if (mySelectedEvents[
                          DateFormat('yyyy-MM-dd').format(_selectedDate!)] !=
                      null) {
                    mySelectedEvents[
                            DateFormat('yyyy-MM-dd').format(_selectedDate!)]
                        ?.add({
                      "eventTitle": titleController.text,
                      "eventDescp": descpController.text,
                    });
                  } else {
                    mySelectedEvents[
                        DateFormat('yyyy-MM-dd').format(_selectedDate!)] = [
                      {
                        "eventTitle": titleController.text,
                        "eventDescp": descpController.text,
                      }
                    ];
                  }
                });

                print(
                    "New Event for backend developer ${json.encode(mySelectedEvents)}");
                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(),
        label: const Text('Add Event'),
      ),
    appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.bookmark_outline),
              tooltip: 'Add an event',
                onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Create new event'),
                      content: Container(
                        width: double.minPositive,
                        
                        child:Column(
                          children: <Widget>[
                            ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter a name for the event',
                                ),
                  
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter the start day',
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter the end day',
                                ),
                              ),
                              onTap: () {},
                            ),
                            
                            MaterialButton(
                              child: Text("C R E A T E"),
                              onPressed: () {
                              setState(() async {});
                              Navigator.pop(context);
                              },
                            ),
                        ]
                        )  
                      ),
                    );
                });
                },
              )
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),            
              child: IconButton(
                icon: const Icon(Icons.add_outlined),
                tooltip: 'Create new',
                onPressed: () {
                  
                },
              )),
        ],
      ),
    body: SfCalendar(
      view: CalendarView.month,
      todayHighlightColor: Color.fromARGB(255, 209, 111, 104),
      cellEndPadding: 5,
      firstDayOfWeek: 1, //start with monday
      showNavigationArrow: true,
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    ));
  }


  List<Meeting> _getDataSource() {
      final List<Meeting> meetings = <Meeting>[];
      final DateTime today = DateTime.now();
      final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
      final DateTime endTime = startTime.add(const Duration(hours: 2));
      meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false,));
      meetings.add(Meeting('Exam EA', startTime, endTime, Color.fromARGB(255, 148, 191, 223), false,));
      meetings.add(Meeting('Meet', startTime, endTime, Color.fromARGB(255, 254, 227, 89), false,));
      return meetings;
  }
}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
class Meeting {
  Meeting(
    this.eventName, 
    this.from, 
    this.to, 
    this.background, 
    this.isAllDay, 
  );
 
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}