import 'package:flutter/material.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/my_location_screen_widget.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/places_card_widget.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen.dart';
import 'package:wetter_app/src/features/weather/presentation/widgets/weather_screen_widget.dart';

ValueNotifier<Color> bottombarColor = ValueNotifier(Colors.blue);

Map<Widget, List<Widget>> places = {
  const PlacesCardWidgetWidget(text: "Mein Standort"): [
    const WeatherScreen(placeIndex: 0),
    MyLocationScreenWidget(bottombarColor: bottombarColor)
  ],
  const PlacesCardWidgetWidget(text: "Istanbul"): [
    const WeatherScreen(placeIndex: 1),
    WeatherScreenWidget(
        name: "Istanbul",
        admin1AndCountry: "Istanbul, Türkei",
        latitude: 41.01384,
        longitude: 28.94966,
        bottombarColor: bottombarColor)
  ],
  const PlacesCardWidgetWidget(text: "Berlin"): [
    const WeatherScreen(placeIndex: 2),
    WeatherScreenWidget(
        name: "Berlin",
        admin1AndCountry: "Berlin, Deutschland",
        latitude: 52.52437,
        longitude: 13.41053,
        bottombarColor: bottombarColor)
  ],
  const PlacesCardWidgetWidget(text: "Tokio"): [
    const WeatherScreen(placeIndex: 3),
    WeatherScreenWidget(
        name: "Tokio",
        admin1AndCountry: "Tokyo Prefecture, Japan",
        latitude: 35.6895,
        longitude: 139.69171,
        bottombarColor: bottombarColor)
  ],
};
