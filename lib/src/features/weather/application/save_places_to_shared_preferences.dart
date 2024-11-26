import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wetter_app/src/features/weather/data/places.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/places_card_widget.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/weather_screen_widget.dart';

Future<void> savePlacesToPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final placesToSave = Map<Widget, List<Widget>>.from(places);

  placesToSave.removeWhere((key, value) =>
      key is PlacesCardWidgetWidget && key.text == "Mein Standort");

  final placesJson = jsonEncode(placesToSave.map((key, value) {
    return MapEntry(
      _widgetToJson(key),
      value.map((e) => _widgetToJson(e)).toList(),
    );
  }));

  await prefs.setString('places', placesJson);
}

String _widgetToJson(Widget widget) {
  if (widget is WeatherScreenWidget) {
    return jsonEncode({
      'type': 'WeatherScreenWidget',
      'name': widget.name,
      'admin1AndCountry': widget.admin1AndCountry,
      'latitude': widget.latitude,
      'longitude': widget.longitude,
    });
  } else if (widget is PlacesCardWidgetWidget) {
    return jsonEncode({
      'type': 'PlacesCardWidgetWIdget',
      'text': widget.text,
    });
  }
  return '';
}
