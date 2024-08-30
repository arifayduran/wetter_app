import 'package:flutter/material.dart';
import 'package:wetter_app/src/features/weather/presentation/weather_screen.dart';

class PlacesCard extends StatefulWidget {
  const PlacesCard({super.key, required this.text});

  final String text;

  @override
  State<PlacesCard> createState() => _PlacesCardState();
}

class _PlacesCardState extends State<PlacesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const WeatherScreen();
            });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/wolken_card.jpeg"),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
