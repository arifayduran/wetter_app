import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:wetter_app/src/features/weather/presentation/my_location_screen.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ValueNotifier<Color> bottombarColor = ValueNotifier(Colors.blue);

  int _currentIndex = 0;

  final List<Widget> _weatherScreenList = [];

  @override
  void initState() {
    super.initState();
    bottombarColor = ValueNotifier(Colors.blue);

    _weatherScreenList.addAll([
      MyLocationScreen(bottombarColor: bottombarColor),
      const WeatherScreenWidget(location: "Berlin"),
    ]);
  }

  @override
  void dispose() {
    bottombarColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bottombarColor,
      builder: (BuildContext context, Color value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: _weatherScreenList[_currentIndex],
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
                    const SizedBox(
                        child: Text(
                      "BAUSTYELL",
                      style: TextStyle(color: Colors.white),
                    )),
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
