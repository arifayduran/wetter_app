String getTodaysDescription(
  Map<int, Map<String, dynamic>> hourlyWeatherData,
) {
  bool hasRain = false;
  bool isMostlyCloudy = false;
  bool isPartlyCloudy = false;
  bool isClear = true;

  double maxTemperature = double.negativeInfinity;
  double minTemperature = double.infinity;

  bool rainInMorning = false;
  bool rainInAfternoon = false;
  bool rainInEvening = false;

  for (var hour in hourlyWeatherData.keys) {
    final hourData = hourlyWeatherData[hour]!;
    final precipitation = hourData["precipitation"] ?? 0.0;
    final cloudCover = hourData["cloudcover"] ?? 0;
    final temperature = hourData["temperature"] ?? 0.0;

    if (precipitation > 0) {
      hasRain = true;
      if (hour >= 6 && hour < 12) {
        rainInMorning = true;
      } else if (hour >= 12 && hour < 18) {
        rainInAfternoon = true;
      } else if (hour >= 18) {
        rainInEvening = true;
      }
    }

    if (cloudCover > 75) {
      isMostlyCloudy = true;
      isClear = false;
    } else if (cloudCover > 25) {
      isPartlyCloudy = true;
      isClear = false;
    }

    if (temperature > maxTemperature) {
      maxTemperature = temperature;
    }
    if (temperature < minTemperature) {
      minTemperature = temperature;
    }
  }

  String description = "";

  if (hasRain) {
    if (rainInMorning) {
      description += "Es wird am Vormittag regnen. ";
    }
    if (rainInAfternoon) {
      description += "Es wird am Nachmittag regnen. ";
    }
    if (rainInEvening) {
      description += "Es wird am Abend regnen. ";
    }
  }

  if (isMostlyCloudy) {
    description += "Der Himmel wird überwiegend bewölkt sein. ";
  } else if (isPartlyCloudy) {
    description += "Der Himmel wird teilweise bewölkt sein. ";
  } else if (isClear) {
    description += "Der Himmel wird klar sein. ";
  }

  if (maxTemperature > 30) {
    description += "Es wird sehr heiß sein. ";
  } else if (minTemperature < 0) {
    description += "Es wird sehr kalt sein. ";
  } else {
    description += "Die Temperaturen werden angenehm sein. ";
  }

  return description;
}
