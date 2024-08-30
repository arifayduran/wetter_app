import 'package:flutter/material.dart';

class WeeklyWeatherWidget extends StatelessWidget {
  const WeeklyWeatherWidget(
      {super.key,
      required this.day,
      required this.imagePath,
      required this.minTemp,
      required this.indicationColors,
      required this.widgetColor,
      required this.maxTemp});
  final String day;
  final String imagePath;
  final double minTemp;
  final List<Color> indicationColors;
  final Color widgetColor;
  final double maxTemp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 0.4,
          height: 20,
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 46,
                child: Text(
                  day,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.4,
                      height: 0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Image.asset(
                imagePath,
              ),
              Row(
                children: [
                  Text(
                    "${minTemp.toStringAsFixed(0)}°  ",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 15.4,
                        height: 0,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: 91,
                    height: 2.5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(colors: indicationColors)),
                  ),
                  Text(
                    "  ${maxTemp.toStringAsFixed(0)}°",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.4,
                        height: 0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
