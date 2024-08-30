import 'dart:convert';

Future<List> fetchLatitudeLongitude(String location) async {
  final url =
      'https://geocoding-api.open-meteo.com/v1/search?name=$location&count=1&language=en&format=json';
  List<String> coordinates = [];

  try {
    var http;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['results'] != null && data['results'].isNotEmpty) {
        final firstResult = data['results'][0];
        final latitude = firstResult['latitude'];
        final longitude = firstResult['longitude'];

        coordinates = [latitude.toString(), longitude.toString()];
      } else {
        coordinates = ['No results found', 'No results found'];
      }
    } else {
      coordinates = ['Failed to load data', 'Failed to load data'];
    }
  } catch (e) {
    coordinates = ['Error fetching data', 'Error fetching data'];
  }
  return coordinates;
}
