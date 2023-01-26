import 'package:flutter/cupertino.dart';
import 'package:flutter_front/models/parking.dart';
import '../models/message.dart';
import '../models/user.dart';
import 'dart:convert';

List<Chat> chatsFromJson(String str) =>
    List<Chat>.from(json.decode(str).map((x) => Chat.fromJson2(x)));

Chat chatFromJson(Map<String, dynamic> str) => Chat.fromJson(str);

class Chat {
  String id;
  String wsclient1;
  String wsclient2;
  String client1;
  String client2;
  List<Messsage> messages;
  Chat(
      {required this.id,
      required this.wsclient1,
      required this.wsclient2,
      required this.client1,
      required this.client2,
      required this.messages});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
      id: json["_id"],
      wsclient1: "",
      wsclient2: "",
      client1: json["client1"],
      client2: json["client2"],
      messages: messagesFromJson(json["messages"]));

  factory Chat.fromJson2(Map<String, dynamic> json) => Chat(
      id: json["_id"],
      client1: json["client1"],
      wsclient1: "",
      client2: json["client2"],
      wsclient2: "",
      messages: []);

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'wsclient1': wsclient1,
      'wsclient2': wsclient2,
      'client2': client2,
      'client1': client1,
      'messages': messages
    };
  }
}
