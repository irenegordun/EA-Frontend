import 'package:flutter/material.dart';
import 'package:flutter_front/models/chat.dart';
import 'package:flutter_front/models/message.dart';
import 'package:flutter_front/models/user.dart';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter_front/services/parkingServices.dart';
import 'package:flutter_front/services/userServices.dart';
import 'package:flutter_front/widgets/message.dart';
import '../widgets/drawer.dart';
import '../widgets/message.dart';
//import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPageMobile extends StatefulWidget {
  @override
  _ChatPageMobileState createState() => _ChatPageMobileState();
}

class _ChatPageMobileState extends State<ChatPageMobile> {
  bool exist = false;
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));
  String info =
      "init/" + StorageAparcam().getId() + "/" + StorageAparcam().getchatname();
  TextEditingController _controller = TextEditingController();
  var isLoaded = false;
  int aa = 0;
  int num = 0;
  var idchat = "";
  List<Messsage>? messages = [];
  //channel.sink.add(StorageAparcam().getId());
  String name = StorageAparcam().getchatname();
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

  _ChatPageMobileState() {
    print("3333333333333333333333333333333");
    channel.stream.listen((data) {
      setState(() async {
        var len = messages!.length;
        print("LEN = " + len.toString());
        if (len == 0) {
          StorageAparcam().setchatkey(data);
          messages = await UserServices().getChat('{ "id":"' + data + '" }');
          print(messages);
          if (messages!.isEmpty) {
            exist = false;
          } else {
            exist = true;
            MessageListView(messages!);
          }
        } else {
          //List<String> a = data.split('/');
          print(data.toString());
          //String a = data.toString().substring(1);
          //print(a);
          Messsage message = Messsage(
              chat: "",
              text: data,
              date: DateTime.now(),
              client: StorageAparcam().getchatname());
          messages!.add(message);
          StorageAparcam().setchats(chats);
        }
        setState(() {});
      });
    });
  }
  @override
  void initState() {
    super.initState();
    channel.sink.add(info);
    getData();
  }

  getData() async {
    print("444444444444444444444444444");
    chats = StorageAparcam().getchats();
    print("55555555555555555555555555555555555555555");
    if (chats != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    chats = StorageAparcam().getchats();
    if (exist == false) {
      int a = 0;
      print(chats!.length);
      for (int i = 0; i < chats!.length; i++) {
        if ((chats![i].client1 == name) && (chats![i].client2 == name)) {
          a = i;
          break;
        }
      }
      print(a);
      if (chats == null || chats!.isEmpty) {
        return Center(child: Text("No chats available"));
      } else {
        messages = chats![a].messages;
      }
      aa = a;
      messages!.sort((a, b) {
        var adate = a.date;
        var bdate = b.date;
        return -adate.compareTo(bdate);
      });
    }
    Messsage mes;
    return MaterialApp(
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          drawer: const DrawerScreen(),
          appBar: buildAppBar(),
          body: Column(
            children: [
              Expanded(child: MessageListView(messages!)),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  hintText: 'Enter text',
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black26),
                  icon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_controller.text != "") {
                          channel.sink.add(StorageAparcam().getchatkey() +
                              "/" +
                              _controller.text +
                              "/" +
                              StorageAparcam().getId());
                          var mes = Messsage(
                              chat: "",
                              text: _controller.text,
                              date: DateTime.now(),
                              client: StorageAparcam().getId());
                          messages!.add(mes);
                          _controller.clear();
                          updateMessages(messages!);
                          chats![aa].messages = messages!;
                          StorageAparcam().setchats(chats);
                        }
                      }),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ));
  }

  MessageListView(List<Messsage>? messages) {
    return ListView.builder(
        itemCount: messages!.length,
        itemBuilder: (context, index) {
          print(messages[index].client.toString());
          print(StorageAparcam().getId().toString());
          if (messages[index].client.toString() ==
              StorageAparcam().getId().toString()) {
            return Card(
                color: Colors.green[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(messages[index].text,
                      style: TextStyle(color: Colors.white)),
                ));
          } else {
            return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(messages[index].text),
                ));
          }
        });
  }

  void updateMessages(List<Messsage> messages) {
    setState(() {
      MessageListView(messages);
    });
  }

  PreferredSizeWidget? buildAppBar() {
    final channelName = StorageAparcam().getchatname();
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Text(channelName),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.phone),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.videocam),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
