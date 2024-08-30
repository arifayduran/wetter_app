String getImagePathWeekly(
  int precipitation,
) {
  switch (precipitation) {
    case > 80:
      return "assets/images/heavyrain.png";
    case > 45:
      return "assets/images/rain.png";
    case > 30:
      return "assets/images/cloudy.png";
    case > 10:
      return "assets/images/partlycloudy.png";
    default:
      return "assets/images/sun.png";
  }
}
