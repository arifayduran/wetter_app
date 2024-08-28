import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.location});
  final String location;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 87,
          ),
          Text(
            "Mein Standort",
            style: TextStyle(fontSize: 25.5, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
