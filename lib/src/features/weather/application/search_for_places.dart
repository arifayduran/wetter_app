// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<List<String>> searchForPlaces(String query) async {
//   final url =
//       'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=100&language=de&format=json';

//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode >= 200 || response.statusCode < 300) {
//     final data = jsonDecode(response.body);
//     final results = data['results'] as List;
//     return results
//         .map((result) => result['name'] +
//             ", " +
//             result['admin1'] +
//             ", " +
//             result['country'] as String)
//         .toList();
//   } else {
//     throw Exception('Failed to load suggestions');
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<List> fetchLatitudeLongitude(String location) async {
//   final url =
//       'https://geocoding-api.open-meteo.com/v1/search?name=$location&count=1&language=en&format=json';
//   List<String> coordinates = [];

//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       if (data['results'] != null && data['results'].isNotEmpty) {
//         final firstResult = data['results'][0];
//         final latitude = firstResult['latitude'];
//         final longitude = firstResult['longitude'];

//         coordinates = [latitude.toString(), longitude.toString()];
//       } else {
//         coordinates = ['No results found', 'No results found'];
//       }
//     } else {
//       coordinates = ['Failed to load data', 'Failed to load data'];
//     }
//   } catch (e) {
//     coordinates = ['Error fetching data', 'Error fetching data'];
//   }
//   return coordinates;
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, List<String>>> searchForPlaces(String query) async {
  final url =
      'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=100&language=de&format=json';

  Map<String, List<String>> placesWithCoordinates = {};
  int retries = 3;

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);

      if (data['results'] != null && data['results'].isNotEmpty) {
        final results = data['results'] as List;

        for (var result in results) {
          final name = result['name'] ?? 'Unbekannt';
          final admin1 = result['admin1'] ?? 'Unbekannt';
          final country = result['country'] ?? 'Unbekannt';

          final latitude = result['latitude']?.toString() ?? '0.0';
          final longitude = result['longitude']?.toString() ?? '0.0';

          placesWithCoordinates[name] = [admin1, country, latitude, longitude];
        }
      }
    } else {
      throw Exception('Failed to load suggestions');
    }
  } catch (e) {
    retries--;
    if (retries == 0) {
      throw Exception('Error fetching data: $e');
    }
    await Future.delayed(const Duration(seconds: 1));
  }

  return placesWithCoordinates;
}
