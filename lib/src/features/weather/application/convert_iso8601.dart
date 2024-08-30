import 'package:intl/intl.dart';

String convertIso8601ToTime(String iso8601String) {
  DateTime dateTime = DateTime.parse(iso8601String);
  final DateFormat formatter = DateFormat('HH:mm');
  return formatter.format(dateTime);
}
