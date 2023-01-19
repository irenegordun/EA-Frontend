import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/views/myBookings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class MyAgenda extends StatefulWidget {
  const MyAgenda({super.key});

  @override
  State<MyAgenda> createState() => _MyAgendaState();
}

class _MyAgendaState extends State<MyAgenda> {
  
  final eventNameController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Center(
          child: Text("My Agenda"),
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
                                controller: eventNameController,
                  
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter the start day',
                                ),
                                controller: fromController,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter the end day',
                                ),
                                controller: toController,
                              ),
                              onTap: () {},
                            ),
                            
                            MaterialButton(
                              child: Text("C R E A T E"),
                              onPressed: () {
                              setState(() async {

                                String formName = eventNameController.text.toString();
                                String formFrom = fromController.text.toString();
                                String formTo = toController.text.toString();
                                /*var meeting = Meeting(
                                  eventName: formName,
                                  from: formFrom,
                                  to: formTo,
                                  background: Colors.blueGrey,
                                  isAllDay : true,
                                );*/
                                //  meetings.add(this.eventName(this.from, this.form, this.to, const Color(0xFF0F8644), this.isAllDay,));
                                //await UserServices().createUser(user);
                              });
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