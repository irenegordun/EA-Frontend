import 'package:flutter/cupertino.dart';
import 'package:flutter_front/models/chat.dart';
import 'package:flutter_front/dates/toDateTime.dart';
import 'dart:convert';

List<Messsage> messagesFromJson(String str) =>
    List<Messsage>.from(json.decode(str).map((x) => Messsage.fromJson(x)));

class Messsage {
  String chat;
  String client;
  DateTime date;
  String text;

  Messsage(
      {required this.chat,
      required this.client,
      required this.date,
      required this.text});

  factory Messsage.fromJson(Map<String, dynamic> json) => Messsage(
      chat: json["chat"],
      client: json["client"],
      date: toDateTimeDart(json["send"]),
      text: json["text"]);
}
