String getImagePathWeatherConditions(
  double precipitation,
  int cloudCover,
  String sunriseTime,
  String sunsetTime,
  int hour,
) {
  final int sunriseHour = int.tryParse(sunriseTime.split(':')[0])!;
  final int sunsetHour = int.tryParse(sunsetTime.split(':')[0])!;

  bool isDayTime = hour >= sunriseHour && hour < sunsetHour;

  if (precipitation > 50) {
    return isDayTime
        ? (cloudCover > 75
            ? "assets/images/heavyrain.png"
            : "assets/images/rain.png")
        : "assets/images/rainynight.png";
  } else {
    if (cloudCover > 70) {
      return isDayTime
          ? "assets/images/cloudy.png"
          : "assets/images/cloudynightpartly.png";
    } else if (cloudCover > 30) {
      return isDayTime
          ? "assets/images/partlycloudy.png"
          : "assets/images/cloudynightpartly.png";
    } else {
      return isDayTime
          ? "assets/images/sun.png"
          : "assets/images/clearnight.png";
    }
  }
}
