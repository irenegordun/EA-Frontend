import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/services/bookingServices.dart';
import 'package:flutter_front/views/ListParkings.dart';
import 'package:flutter_front/models/user.dart';
import 'package:flutter_open_street_map/flutter_open_street_map.dart';
import 'package:provider/provider.dart';
import 'package:flutter_front/models/chat.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/models/message.dart';
import '../models/parking.dart';
import '../views/Chat.dart';
import '../models/booking.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ParkingInfo extends StatefulWidget {
  const ParkingInfo({super.key});

  @override
  State<ParkingInfo> createState() => _ParkingInfoState();
}

class _ParkingInfoState extends State<ParkingInfo> {
  double rating = 0;   
  var isLoaded = false;
  User? owner;
  DateTime? firstdate;
  DateTime? seconddate;
  List<DateTime> availableDates1 = [];
  final dateFormat = DateFormat("dd/MM/yyyy");

  bool _isVisible1 = true;
  bool _isVisible2 = true;

  void showToast() {
    setState(() {
      _isVisible1 = !_isVisible1;
      _isVisible2 = !_isVisible2;

    });
  }

  BookingParking(Booking booking) async {
    BookingServices().createBooking(booking);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ListParkings()));
  }
  
  @override
  Widget build(BuildContext context) {
    ParkingServices _parkingprovider = Provider.of<ParkingServices>(context);
    availableDates1 = _parkingprovider.parkingData.range
        .split(" - ")
        .map((date) => dateFormat.parse(date))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("A P A R C A ' M"),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close_outlined),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListParkings()));
            },
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(child: _buildCard(_parkingprovider.parkingData)),
    );
  }

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromARGB(255, 230, 241, 248),
          shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)),
          title: Text ("APARCA'M", style: TextStyle(fontSize: 17)),
          content: Text(text, style: TextStyle(fontSize: 15)),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: submit,
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget _buildCard(Parking parking) => SizedBox(
        height: 600,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: const Text('Direction',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(
                    '${parking.street} ${parking.streetNumber.toString()}, ${parking.city}, ${parking.country}'),
                leading: const Icon(
                  Icons.where_to_vote_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Price'),
                subtitle: Text('${parking.price}€/day'),
                leading: const Icon(
                  Icons.attach_money_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Type'),
                subtitle: Text(parking.type),
                leading: const Icon(
                  Icons.two_wheeler,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Size'),
                subtitle: Text(parking.size),
                leading: const Icon(
                  Icons.aspect_ratio_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              ListTile(
                title: const Text('Difficulty'),
                subtitle: Text(parking.difficulty.toString()),
                leading: const Icon(
                  Icons.hardware_outlined,
                  color: Color.fromARGB(255, 39, 51, 58),
                ),
              ),
              TextButton(
                child: Text("Book"),
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color.fromARGB(255, 55, 71, 80),
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  firstdate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: availableDates1[0],
                    lastDate: availableDates1[1],
                  );
                  seconddate = await showDatePicker(
                    context: context,
                    initialDate: firstdate ?? DateTime.now(),
                    firstDate: availableDates1[0],
                    lastDate: availableDates1[1],
                  );

                  Booking booking1 = Booking(
                      arrival: firstdate.toString(),
                      departure: seconddate.toString(),
                      cost: parking.price,
                      customer: StorageAparcam().getId(),
                      parking: parking.id,
                      id: "",
                      owner: "");
                  BookingParking(booking1);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: ElevatedButton(
                  onPressed: () async {
                    owner = await ParkingServices().getOwner(parking);
                    if (owner!.id != StorageAparcam().getId()) {
                      List<Messsage>? messages = [];
                      Chat chat = Chat(
                          id: "",
                          wsclient1: "",
                          wsclient2: "",
                          client2: owner!.name,
                          client1: StorageAparcam().getId(),
                          messages: messages);
                      User user1 = User(
                          name: "",
                          id: StorageAparcam().getId(),
                          password: "",
                          email: "",
                          points: 0,
                          myFavorites: [],
                          myParkings: [],
                          chats: [],
                          myBookings: [],
                          deleted: false,
                          newpassword: "");
                      List<Chat>? chats = [];
                      try {
                        chats = await UserServices().getchats(user1);
                      } catch (err) {
                        print("NO CHATS RETURNED");
                      }
                      chats!.add(chat);
                      StorageAparcam().setchats(chats);
                      StorageAparcam().setchatname(owner!.name);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatPageMobile()));
                    } else {
                      openDialog("This parking alredy belongs to you");
                    }
                  },
                  child: const Text('Chat'),
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.blueGrey),
                  ),
                ),
              ),
              Row(
                 children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Visibility(
                    visible: _isVisible1,
                    child: Column(
                      
                      children: [
                        Row(
                          children: <Widget>[ 
                          Expanded(
                            flex: 8,
                            
                            child: Container(
                              height: 130,
                              child:  Center(
                               child: Text("Select the score",style: const TextStyle(fontSize: 15))),
                              
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 196, 202, 205),
                                
                              ),
                            ),

                          ),
                          Expanded(
                            
                            flex: 2,

                            child: Container(
                              height: 130,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 196, 202, 205),
                                
                              ),
                              child: IconButton(
                              icon: const Icon(Icons.highlight_remove_sharp, size: 20, color: Color.fromARGB(255, 101, 101, 101)),
                              tooltip: 'Close',
                              onPressed: () {
                                setState(() {
                                  _isVisible1 = !_isVisible1;
                                });
                              },
                            ),    
                            )
                          ),
                          ]
                        )
                      ],
                      

                  ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Visibility(
                  visible: _isVisible2,
                  child: Column(
                    
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rating: $rating',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      width: 25,
                      height: 25,
                    ),
                    RatingBar.builder(
                      minRating: 1,
                      maxRating: 5,
                      initialRating: 0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_border_outlined, size:7.0,
                        color: Color.fromARGB(255, 230, 211, 65),
                      ),
                      onRatingUpdate: (rating) => setState(() {
                        this.rating = rating;
                      }),
                      updateOnDrag: true,
                    ),
                      SizedBox(
                      width: 40,
                      height: 40,
                      child:TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          parking.score = rating.toInt();
                          setState(() {
                            _isVisible2 = !_isVisible2;
                          });
                        },
                      ),
                    ),
                  ],
                )),
                )


            ]),
            ],
          ),
        ),
      );
}
