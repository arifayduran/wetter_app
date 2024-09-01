import 'package:flutter/material.dart';
import 'package:wetter_app/src/features/weather/presentation/my_location_screen.dart';
import 'package:wetter_app/src/features/weather/presentation/places_card.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen_widget.dart';

ValueNotifier<Color> bottombarColor = ValueNotifier(Colors.blue);

Map<Widget, List<Widget>> places = {
  const PlacesCard(text: "Mein Standort"): [
    const WeatherScreen(placeIndex: 0),
    MyLocationScreen(bottombarColor: bottombarColor)
  ],
  const PlacesCard(text: "Istanbul"): [
    const WeatherScreen(placeIndex: 1),
    WeatherScreenWidget(
        name: "Istanbul",
        admin1AndCountry: "Istanbul, Turkey",
        latitude: 23,
        longitude: 33,
        bottombarColor: bottombarColor)
  ]
};
