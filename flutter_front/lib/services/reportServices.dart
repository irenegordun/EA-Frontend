import 'dart:convert';
import 'dart:html';
import 'package:flutter_front/services/localStorage.dart';
import 'package:flutter/material.dart';
import '../models/report.dart';
import 'package:http/http.dart' as http;

class ReportServices extends ChangeNotifier {
  Report _reportData = Report(type: "", id: "", user: "", text: "", level: 0);
  Report get parkingData => _reportData;

  void setParkingData(Report reportData) {
    _reportData = reportData;
  }

  Future<List<Report>?> getReports() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:5432/api/reports/');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return reportFromJson(json);
    }
    return null;
  }

  Future<void> createReport(Report report) async {
    var client = http.Client();
    var id = StorageAparcam().getId();
    var uri = Uri.parse('http://localhost:5432/api/reports/$id');
    var reportJS = json.encode(report.toJson());
    var response = await client.post(uri,
        headers: {
          'content-type': 'application/json',
          'x-access-token': StorageAparcam().getToken()
        },
        body: reportJS);
    if (response.statusCode == 200) {
      return print("Report created");
    } else {
      return print("ERROR: can't create the report");
    }
  }

  Future<void> deleteReport(Report report) async {
    var client = http.Client();
    var id = report.id;
    var uri = Uri.parse('http://localhost:5432/api/parkings/$id');
    var reportJS = jsonEncode(report.toJson());
    var response = await client.delete(uri,
        headers: {'content-type': 'application/json'}, body: reportJS);
    if (response.statusCode == 200) {
      return print("deleted");
    }
    return null;
  }
}
