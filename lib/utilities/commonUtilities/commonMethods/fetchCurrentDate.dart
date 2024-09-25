import 'dart:convert';

import 'package:http/http.dart' as http;

Future<DateTime> fetchCurrentDateTime() async {
  final response = await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final DateTime dateTime = DateTime.parse(data['utc_datetime']);
    return dateTime.toLocal();
  } else {
    throw Exception('Failed to fetch current date and time');
  }
}
