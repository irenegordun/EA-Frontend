import 'dart:convert';

List<Report> reportFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

Report parkingFromJson(Map<String, dynamic> str) => Report.fromJson(str);

String parkingToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
  Report({
    required this.id,
    required this.user,
    required this.level,
    required this.text,
    required this.type,
  });
  String id;
  String user;
  String type;
  String text;
  int level;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
      id: json["_id"],
      user: json["user"],
      type: json["type"],
      text: json["text"],
      level: json["level"]);

  Map<String, dynamic> toJson() =>
      {"_id": id, "type": type, "user": user, "text": text, "level": level};
}
