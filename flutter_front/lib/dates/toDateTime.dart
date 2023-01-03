import 'package:intl/intl.dart';

toDateTimeDart(value) {
  DateTime? dateTime = DateTime.now();
  if (value != null || value.isNotEmpty) {
    try {
      dateTime =
          DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(value, false).toLocal();
    } catch (e) {
      print("$e");
    }
  }
  return dateTime;
}

toDateMongo(value1) {
  DateTime datetime1 = value1;
  return datetime1.toIso8601String();
}
