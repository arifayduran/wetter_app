double getIndicatorPosition(
  double temp,
  double minTemp,
  double maxTemp,
  double totalWidth,
) {
  double normalizedTemp = (temp - minTemp) / (maxTemp - minTemp);
  normalizedTemp = normalizedTemp.clamp(0.0, 1.0);
  double position = normalizedTemp * totalWidth;

  return position;
}
