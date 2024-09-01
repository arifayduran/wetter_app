import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:wetter_app/src/features/weather/data/places.dart';
// import 'package:wetter_app/src/features/weather/presentation/weather_screen_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.placeIndex});

  final int placeIndex;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.placeIndex;
    bottombarColor.value = Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bottombarColor,
      builder: (BuildContext context, Color value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: places.values.toList()[_currentIndex][1],
          bottomNavigationBar: Container(
            height: 72,
            color: value.withOpacity(.8),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      "BAUSTYELL",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const SFIcon(
                        SFIcons.sf_list_bullet,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
