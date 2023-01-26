import 'package:flutter_front/models/booking.dart';
import 'package:flutter_front/services/bookingServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_front/views/myBookings.dart';
import 'package:provider/provider.dart';

class MyBookingInfo extends StatefulWidget {
  const MyBookingInfo({super.key});

  @override
  State<MyBookingInfo> createState() => _MyBookingInfoState();
}

class _MyBookingInfoState extends State<MyBookingInfo> {
  @override
  Widget build(BuildContext context) {
    BookingServices _bookingprovider = Provider.of<BookingServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFO BOOKING'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close_outlined),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const myBookings()));
            },
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: _buildCard(_bookingprovider.bookingData)),
    );
  }

  Widget _buildCard(Booking booking) => SizedBox(
        height: 600,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('Dates booked',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle:
                    Text('From ${booking.arrival} - to ${booking.departure}'),
                leading: const Icon(
                  Icons.date_range,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Total cost'),
                subtitle: Text(booking.cost.toString()),
                leading: const Icon(
                  Icons.attach_money_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Booked from user'),
                subtitle: Text(booking.owner),
                leading: const Icon(
                  Icons.person_outline_sharp,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Parking location'),
                subtitle: Text(booking.parking),
                leading: const Icon(
                  Icons.location_pin,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
            ],
          ),
        ),
      );
}
