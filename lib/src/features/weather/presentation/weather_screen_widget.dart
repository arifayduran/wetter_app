import 'package:flutter/material.dart';

class WeatherScreenWidget extends StatefulWidget {
  const WeatherScreenWidget({super.key, required this.location});
  final String location;

  @override
  State<WeatherScreenWidget> createState() => _WeatherScreenWidgetState();
}

class _WeatherScreenWidgetState extends State<WeatherScreenWidget> {
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
