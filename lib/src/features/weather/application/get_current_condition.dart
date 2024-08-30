String getCurrentCondition(
  double precipitation,
  int cloudCover,
  String sunriseTime,
  String sunsetTime,
  int hour,
) {
  final int sunriseHour = int.tryParse(sunriseTime.split(':')[0])!;
  final int sunsetHour = int.tryParse(sunsetTime.split(':')[0])!;

  bool isDayTime = hour >= sunriseHour && hour < sunsetHour;

  if (precipitation > 0) {
    return isDayTime ? (cloudCover > 75 ? "Armageddon" : "Regen") : "Regen";
  }

  if (cloudCover > 65) {
    return isDayTime ? "Stark Bewölkt" : "Stark Bewölkt";
  } else if (cloudCover > 25) {
    return isDayTime ? "Teilweise Bewölkt" : "Teilweise Bewölkt";
  } else {
    return isDayTime ? "Sonnig" : "Klarer Himmel";
  }
}
