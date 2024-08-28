import 'package:flutter/material.dart';
import 'package:wetter_app/src/features/weather/presentation/my_location_screen.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _weatherScreenList = [
    const MyLocationScreen(),
    const WeatherScreen(
      location: "Berlin",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/Wetter an meinem Standort anzeigen.jpeg"))),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: _weatherScreenList[_currentIndex],
        bottomNavigationBar: Container(
          height: 72,
          color: Colors.blue.withOpacity(0.5),
          child: Row(
            children: [],
          ),
        ),
      ),
    );
  }
}
