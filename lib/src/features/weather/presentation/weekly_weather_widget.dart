  // for (int i = 0; i < 7; i++) {
  //                                     final day = DateTime.now().add(Duration(days: i));
  //                                     final data =
  //                                         _dailyWeatherData[day.toString()]??
  //                                         _dailyWeatherData[day.toString()
  //                                            .substring(0, 10)];
  //                                     return _isWeatherDataLoading
  //                                        ? const SizedBox()
  //                                         : DayWeather(
  //                                             dayOfWeek: day.weekday.toString(),
  //                                             imagePath:
  //                                                 getImagePathWeatherConditions(
  //                                                 data["precipitationprobability"]
  //                                                     .toDouble(),
  //                                                 data["cloudcover"],
  //                                                 _todaySunriseTime!,
  //                                                 _todaySunsetTime!,
  //                                                 day.hour),
  //                                             temperature:
  //                                                 "${data["temperatureMax"]?.toStringAsFixed(0)}° / ${data["temperatureMin"]?.toStringAsFixed(0)}°",
  //                                             precipitation:
  //                                                 "${data["precipitationprobability"]?.toStringAsFixed(0)}%",
  //                                             humidity