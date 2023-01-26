import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/models/user.dart';
import 'package:flutter_front/models/chat.dart';
import '../models/message.dart';
import '../views/Chat.dart';

import '../services/localStorage.dart';
import 'package:flutter_front/widgets/user_image_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HomePageMobile extends StatelessWidget {
  List<Chat>? chats;
  List<Messsage>? messages = [];
  @override
  Widget build(BuildContext context) => Scaffold(
      drawer: const DrawerScreen(),
        appBar: AppBar(
          title: const Center(
            child: Text("A P A R C A ' M"),
          ),
          centerTitle: true,
          leading: UserImageWidget(),
          actions: [
            IconButton(icon: Icon(Icons.edit), onPressed: () => {}),
            SizedBox(width: 8),
          ],
        ),
        body: buildListView(context),
      );

  openchat(List<Chat> chats1, String client, context) async {
    StorageAparcam().setchats(chats1);
    StorageAparcam().setchatname(client);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ChatPageMobile()));
  }

  Widget buildListView(BuildContext context) {
    return FutureBuilder<List<Chat>>(
        future: getchats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: chats?.length,
              itemBuilder: (context, index) {
                return FutureBuilder<String>(
                    future: name(chats![index]),
                    builder: (context, snapshot) {
                      return GestureDetector(
                        child: Card(
                            color: Color.fromARGB(255, 144, 180, 199),
                            child: ListTile(
                              leading: Container(
                                width: 80,
                                height: 80,
                              ),
                              title: Text(snapshot.data!),
//subtitle: Text(
//chats![index].messages?.last?.toString() ?? ''),
                            )),
                        onTap: () =>
                            {openchat(chats!, snapshot.data!, context)},
                      );
                    });
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<String> name(Chat cht) async {
    String id = "";
    if (cht.client1 == StorageAparcam().getId()) {
      id = cht.client2;
    } else {
      id = cht.client1;
    }
    var user1 = User(
        id: id,
        name: "",
        password: "",
        email: "",
        myFavorites: [],
        myParkings: [],
        chats: [],
        myBookings: [],
        points: 0,
        deleted: false,
        newpassword: "");
    User? user = await UserServices().getOneUser(user1);
    if (user != null) {
      return Future.value(user.name);
    } else {
      return Future.value("");
    }
  }

  Future<List<Chat>> getchats() async {
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
    try {
      chats = await UserServices().getchats(user1);
    } catch (err) {
      print("NO CHATS RETURNED");
    }
    print("CHATS OBTENIDOS: ");
    print(chats);
    StorageAparcam().setchats(chats);
    return Future.value(chats);
  }
}
