class HourlyWeatherData {
  HourlyWeatherData({
    required this.time,
    required this.temperature2M,
    required this.precipitationProbability,
    required this.precipitation,
  });

  final List<String> time;
  final List<double> temperature2M;
  final List<int> precipitationProbability;
  final List<double> precipitation;
}
