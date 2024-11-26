import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/places_card_widget.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/weather_screen_widget.dart';

Future<Map<Widget, List<Widget>>> loadPlacesFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final placesJson = prefs.getString('places');

  if (placesJson == null || placesJson.isEmpty) {
    return {};
  }

  try {
    final Map<String, dynamic> placesMap = jsonDecode(placesJson);
    final places = <Widget, List<Widget>>{};

    placesMap.forEach((key, value) {
      final widget = _jsonToWidget(key);
      final widgetList = (value as List<dynamic>)
          .map((e) => _jsonToWidget(e))
          .whereType<Widget>()
          .toList();

      if (widget != null) {
        places[widget] = widgetList;
      }
    });

    return places;
  } catch (e) {
    debugPrint('Error decoding JSON: $e');
    return {};
  }
}

Widget? _jsonToWidget(String json) {
  final Map<String, dynamic> data = jsonDecode(json);

  switch (data['type']) {
    case 'WeatherScreenWidget':
      return WeatherScreenWidget(
        name: data['name'],
        admin1AndCountry: data['admin1AndCountry'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        bottombarColor: ValueNotifier<Color>(Colors.blue),
      );
    case 'PlacesCardWidgetWIdget':
      return PlacesCardWidgetWidget(text: data['text']);
    default:
      return null;
  }
}

Map<Widget, List<Widget>> placesFromJson(Map<String, dynamic> jsonMap) {
  final places = <Widget, List<Widget>>{};

  jsonMap.forEach((key, value) {
    final widgetKey = _jsonToWidget(key);
    final widgetList = (value as List<dynamic>)
        .map((e) => _jsonToWidget(jsonEncode(e)))
        .whereType<Widget>()
        .toList();

    if (widgetKey != null) {
      places[widgetKey] = widgetList;
    }
  });

  return places;
}