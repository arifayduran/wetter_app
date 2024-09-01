import 'package:flutter/material.dart';

class HourlyWeather extends StatefulWidget {
  const HourlyWeather(
      {super.key,
      required this.time,
      required this.imagePath,
      required this.temperature});

  final String time;
  final String imagePath;
  final String temperature;

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0.0, bottom: 15, left: 9, right: 10.5),
      child: SizedBox(
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.time,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
              child: Image.asset(
                widget.imagePath,
              ),
            ),
            Text(
              widget.temperature,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
