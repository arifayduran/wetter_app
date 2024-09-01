String getCurrentCondition(
  double precipitation,
  int cloudCover,
  String sunriseTime,
  String sunsetTime,
  String currentTime,
) {
  final int sunriseHour = int.tryParse(sunriseTime.split(':')[0])!;
  final int sunriseMinute = int.tryParse(sunriseTime.split(':')[1])!;

  final int sunsetHour = int.tryParse(sunsetTime.split(':')[0])!;
  final int sunsetMinute = int.tryParse(sunsetTime.split(':')[1])!;

  final int currentHour = int.tryParse(currentTime.split(':')[0])!;
  final int currentMinute = int.tryParse(currentTime.split(':')[1])!;

 
  bool isAfterSunrise = (currentHour > sunriseHour) ||
      (currentHour == sunriseHour && currentMinute >= sunriseMinute);
  bool isBeforeSunset = (currentHour < sunsetHour) ||
      (currentHour == sunsetHour && currentMinute < sunsetMinute);

  bool isDayTime = isAfterSunrise && isBeforeSunset;


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
