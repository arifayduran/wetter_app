import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:wetter_app/src/features/weather/application/geolocator_determine_position.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  double? _latitude;
  double? _longitude;
  String? _location;
  double? _currentDegree;
  double? _currentPrecipitation;
  String? _currentCondition;
  double? _todayMaxDegree;
  double? _todayMinDegree;
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
        _location =
            '${place.locality}, ${place.administrativeArea}, ${place.country}';
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
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)'
    };
    var url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$_latitude&longitude=$_longitude&current=temperature_2m%2Cprecipitation&hourly=temperature_2m%2Cprecipitation_probability%2Cprecipitation&daily=temperature_2m_max%2Ctemperature_2m_min%2Cprecipitation_sum%2Cprecipitation_probability_max&timezone=auto');

    try {
      var req = http.Request('GET', url);
      req.headers.addAll(headersList);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        setState(() {
          _isWeatherDataLoading = false;
        });

        final Map<String, dynamic> data = json.decode(resBody);
        _currentDegree = data['current']['temperature_2m'];
        _currentPrecipitation = data['current']['precipitation'];
        _currentCondition = _getCurrentPrecipitation(_currentPrecipitation!);

        var maxList = data['daily']['temperature_2m_max'];
        var findMax = maxList[0];

        for (var i = 0; i < maxList.length; i++) {
          if (maxList[i] > findMax) {
            findMax = maxList[i];
          }
        }
        _todayMaxDegree = findMax;

        var minList = data['daily']['temperature_2m_min'];
        var findMin = minList[0];

        for (var i = 0; i < minList.length; i++) {
          if (minList[i] < findMin) {
            findMin = minList[i];
          }
        }
        _todayMinDegree = findMin;
      } else {
        setState(() {
          _isWeatherDataLoading = false;
        });
        print('Error: ${res.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        _isWeatherDataLoading = false;
      });
      print('Exception: $e');
    }
  }

  String _getCurrentPrecipitation(double precipitation) {
    if (_currentPrecipitation! >= 0 && _currentPrecipitation! < 20) {
      return "Sonnig";
    } else if (_currentPrecipitation! >= 20 && _currentPrecipitation! < 40) {
      return "Feucht";
    } else if (_currentPrecipitation! >= 40 && _currentPrecipitation! < 80) {
      return "Regen";
    } else if (_currentPrecipitation! >= 80 && _currentPrecipitation! < 100) {
      return "Armageddon";
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 87),
            GestureDetector(
              onTap: () {
                _getLocation();
              },
              child: const Text(
                "Mein Standort",
                style: TextStyle(fontSize: 25.5, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              child: _isLocationLoading
                  ? const CircularProgressIndicator()
                  : _location != null
                      ? Text(
                          _location!,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'Fehler beim Abrufen des Standorts',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
            ),
            SizedBox(
              height: 90,
              child: _isWeatherDataLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      _currentDegree != null
                          ? "  ${_currentDegree?.toStringAsFixed(0)}°"
                          : 'N/A',
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
                  ? const CircularProgressIndicator()
                  : Text(
                      _currentCondition ?? "N/A",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
            ),
            SizedBox(
              height: 16,
              child: _isWeatherDataLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      _currentDegree != null
                          ? "H: ${_todayMaxDegree?.toStringAsFixed(0)}° T: ${_todayMinDegree?.toStringAsFixed(0)}°"
                          : 'N/A',
                      style: const TextStyle(
                          fontSize: 16,
                          height: 0,
                          letterSpacing: 0,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  Text("data"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
