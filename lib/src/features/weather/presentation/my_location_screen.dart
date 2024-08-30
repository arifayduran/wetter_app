import "package:flutter/material.dart";
import "package:flutter_sficon/flutter_sficon.dart";
import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:http/http.dart" as http;
import "package:wetter_app/src/features/weather/application/convert_iso8601.dart";
import "dart:convert";
import "package:wetter_app/src/features/weather/application/geolocator_determine_position.dart";
import "package:wetter_app/src/features/weather/application/get_current_condition.dart";
import "package:wetter_app/src/features/weather/application/get_image_path.dart";
import "package:wetter_app/src/features/weather/application/get_todays_description.dart";
import "package:wetter_app/src/features/weather/presentation/hourly_weather_widget.dart";

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  String? _errorMessage;
  String? _descriptionText;
  double? _latitude;
  double? _longitude;
  String? _location;
  double? _currentDegree;
  double? _currentPrecipitation;
  int? _currentCloudCover;
  String? _currentCondition;
  double? _todayMaxDegree;
  double? _todayMinDegree;
  String? _todaySunriseTime;
  String? _todaySunsetTime;
  Map<int, Map<String, dynamic>> _hourlyWeatherData = {};

  bool _isLocationLoading = true;
  bool _isWeatherDataLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    setState(() {
      _isLocationLoading = true;
    });
    try {
      final Position position = await determinePosition();
      _latitude = position.latitude;
      _longitude = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _isLocationLoading = false;
        _location = "${place.locality}, ${place.country}";
        requestWeatherData();
      });
    } catch (e) {
      setState(() {
        _isLocationLoading = false;
      });
    }
  }

  Future<void> requestWeatherData() async {
    setState(() {
      _isWeatherDataLoading = true;
    });

    var headersList = {
      "Accept": "*/*",
      "User-Agent": "Thunder Client (https://www.thunderclient.com)"
    };
    var url = Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$_latitude&longitude=$_longitude&current=temperature_2m%2Cprecipitation%2Ccloud_cover&hourly=temperature_2m%2Cprecipitation_probability%2Cprecipitation%2Ccloud_cover&daily=temperature_2m_max%2Ctemperature_2m_min%2Csunrise%2Csunset%2Cprecipitation_sum%2Cprecipitation_probability_max&timezone=auto");

    try {
      var req = http.Request("GET", url);
      req.headers.addAll(headersList);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(resBody);
        setState(() {
          _isWeatherDataLoading = false;

          _todaySunriseTime = convertIso8601ToTime(data["daily"]["sunrise"][0]);
          _todaySunsetTime = convertIso8601ToTime(data["daily"]["sunset"][0]);

          _currentDegree = data["current"]["temperature_2m"];
          _currentPrecipitation = data["current"]["precipitation"];
          _currentCloudCover = data["current"]["cloud_cover"];
          _currentCondition = getCurrentCondition(
              _currentPrecipitation!,
              _currentCloudCover!,
              _todaySunriseTime!,
              _todaySunsetTime!,
              DateTime.now().hour);

          var maxList = data["daily"]["temperature_2m_max"];
          var findMax = maxList[0];

          for (var i = 0; i < maxList.length; i++) {
            if (maxList[i] > findMax) {
              findMax = maxList[i];
            }
          }
          _todayMaxDegree = findMax;

          var minList = data["daily"]["temperature_2m_min"];
          var findMin = minList[0];

          for (var i = 0; i < minList.length; i++) {
            if (minList[i] < findMin) {
              findMin = minList[i];
            }
          }
          _todayMinDegree = findMin;

          final hourlyWeatherMap = <int, Map<String, dynamic>>{};

          for (int i = DateTime.now().hour + 1;
              i <= (DateTime.now().hour + 24);
              i++) {
            hourlyWeatherMap[i] = {
              "temperature": data["hourly"]["temperature_2m"][i],
              "precipitationprobability": data["hourly"]
                  ["precipitation_probability"][i],
              "precipitation": data["hourly"]["precipitation"][i],
              "cloudcover": data["hourly"]["cloud_cover"][i],
            };

            _hourlyWeatherData = hourlyWeatherMap;

            _descriptionText = getTodaysDescription(_hourlyWeatherData);
          }
          ;
        });
      } else {
        setState(() {
          _isWeatherDataLoading = false;
          _errorMessage = "Error: ${res.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        _isWeatherDataLoading = false;
        _errorMessage = "Exception: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: RefreshIndicator(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        onRefresh: _getLocation,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 87),
              const Text(
                "Mein Standort",
                style: TextStyle(fontSize: 25.5, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
                child: _isLocationLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : _location != null
                        ? Text(
                            _location!,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          )
                        : const Text(
                            "Fehler beim Abrufen des Standorts",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
              ),
              SizedBox(
                height: 90,
                child: _isWeatherDataLoading
                    ? const SizedBox(
                        height: 90,
                        width: 90,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : Text(
                        _currentDegree != null
                            ? "  ${_currentDegree?.toStringAsFixed(0)}°"
                            : "N/A",
                        style: const TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            height: 1),
                      ),
              ),
              SizedBox(
                height: 23,
                child: _isWeatherDataLoading
                    ? const SizedBox()
                    : Text(
                        _currentCondition ?? "N/A",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                height: 16,
                child: _isWeatherDataLoading
                    ? const SizedBox()
                    : Text(
                        _currentDegree != null
                            ? "H: ${_todayMaxDegree?.toStringAsFixed(0)}° T: ${_todayMinDegree?.toStringAsFixed(0)}°"
                            : "N/A",
                        style: const TextStyle(
                            fontSize: 16,
                            height: 0,
                            letterSpacing: 0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
                child: _isWeatherDataLoading
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 17,
                            child: Image.asset(
                              "assets/images/sunrise.png",
                            ),
                          ),
                          Text(
                            "  $_todaySunriseTime",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          SizedBox(
                            height: 17,
                            child: Image.asset(
                              "assets/images/sunset.png",
                            ),
                          ),
                          Text(
                            "  $_todaySunsetTime",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 29,
                child: _errorMessage != null
                    ? Text(
                        _errorMessage!,
                        style:
                            const TextStyle(fontSize: 11.5, color: Colors.red),
                      )
                    : const SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Container(
                  height: 136,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(1),
                      borderRadius: BorderRadius.circular(13)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _isWeatherDataLoading
                                ? const SizedBox()
                                : Text(
                                    _descriptionText!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.2,
                                        height: 0,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 13,
                        thickness: 0.4,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: _isWeatherDataLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      HourlyWeather(
                                        time: "Jetzt",
                                        imagePath:
                                            getImagePathWeatherConditions(
                                                _currentPrecipitation!,
                                                _currentCloudCover!,
                                                _todaySunriseTime ?? "6:00",
                                                _todaySunsetTime ?? "20:00",
                                                DateTime.now().hour),
                                        temperature: _currentDegree != null
                                            ? "  ${_currentDegree?.toStringAsFixed(0)}°"
                                            : "N/A",
                                      ),
                                      ..._hourlyWeatherData.entries
                                          .map((entry) {
                                        final hour = entry.key > 24
                                            ? entry.key - 24
                                            : entry.key;
                                        final data = entry.value;
                                        return _isWeatherDataLoading
                                            ? const SizedBox()
                                            : HourlyWeather(
                                                time: "$hour Uhr",
                                                imagePath:
                                                    getImagePathWeatherConditions(
                                                  data["precipitationprobability"]
                                                      .toDouble(),
                                                  data["cloudcover"],
                                                  _todaySunriseTime!,
                                                  _todaySunsetTime!,
                                                  hour,
                                                ),
                                                temperature:
                                                    "${data["temperature"]?.toStringAsFixed(0)}°",
                                              );
                                      }),
                                    ],
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(13)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 21,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SFIcon(
                                  SFIcons.sf_calendar,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                Text(
                                  " 7-TAGE-VORHERSAGE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      height: 0,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 13,
                        thickness: 0.4,
                        endIndent: 13,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: _isWeatherDataLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Heute",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.4,
                                                  height: 0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        indent: 13,
                                        thickness: 0.4,
                                        endIndent: 13,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Do",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.4,
                                                  height: 0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
