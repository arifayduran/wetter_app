import 'package:flutter/material.dart';

List<Color> getIndicationColors(double minTemp, double maxTemp) {
  List<Color> colors = [];

  if (maxTemp > 20) {
    colors = [Colors.yellowAccent, Colors.redAccent];
  } else if (minTemp >= 0 && maxTemp <= 20) {
    colors = [Colors.blueAccent, Colors.yellowAccent];
  } else if (minTemp < 0) {
    colors = [Colors.white, Colors.blueAccent];
  }

  return colors;
}
