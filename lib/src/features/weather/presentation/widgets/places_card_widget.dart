import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sficon/flutter_sficon.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wetter_app/src/config/logical_size.dart';
import 'package:wetter_app/src/features/weather/application/get_current_condition.dart';

class PlacesCardWidgetWidget extends StatefulWidget {
  const PlacesCardWidgetWidget({
    super.key,
    required this.text,
    this.latitude,
    this.longitude,
    this.isMyLocation = false,
  });

  final String text;
  final double? latitude;
  final double? longitude;
  final bool isMyLocation;

  @override
  State<PlacesCardWidgetWidget> createState() => _PlacesCardWidgetWIdgetState();
}

class _PlacesCardWidgetWIdgetState extends State<PlacesCardWidgetWidget> {
  bool _isLoading = true;
  double? _currentTemp;
  double? _maxTemp;
  double? _minTemp;
  String? _condition;
  String? _localTime;

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      _fetchWeatherData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchWeatherData() async {
    try {
      final url = Uri.parse(
        "https://api.open-meteo.com/v1/forecast?"
        "latitude=${widget.latitude}&longitude=${widget.longitude}"
        "&current=temperature_2m,precipitation,cloud_cover"
        "&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset"
        "&timezone=auto",
      );

      final response = await http.get(url);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);

        final currentTemp = data["current"]["temperature_2m"];
        final precipitation = data["current"]["precipitation"];
        final cloudCover = data["current"]["cloud_cover"];
        final maxTemp = data["daily"]["temperature_2m_max"][0];
        final minTemp = data["daily"]["temperature_2m_min"][0];
        final sunrise = data["daily"]["sunrise"][0];
        final sunset = data["daily"]["sunset"][0];
        final currentTimeIso = data["current"]["time"];

        // Parse time from ISO format
        final dateTime = DateTime.parse(currentTimeIso);
        final timeFormatter = DateFormat('HH:mm');
        final localTime = timeFormatter.format(dateTime);

        // Get sunrise/sunset times
        final sunriseTime = timeFormatter.format(DateTime.parse(sunrise));
        final sunsetTime = timeFormatter.format(DateTime.parse(sunset));

        final condition = getCurrentCondition(
          (precipitation as num).toDouble(),
          (cloudCover as num).toInt(),
          sunriseTime,
          sunsetTime,
          localTime,
        );

        if (mounted) {
          setState(() {
            _currentTemp = (currentTemp as num).toDouble();
            _maxTemp = (maxTemp as num).toDouble();
            _minTemp = (minTemp as num).toDouble();
            _condition = condition;
            _localTime = localTime;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: kIsWeb
            ? logicWidth - 10 - 13 - 13
            : MediaQuery.of(context).size.width - 10 - 13 - 13,
        height: 100,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/wolken_card.jpeg"),
                fit: BoxFit.cover,
                opacity: 0.9),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 200,
                    child: widget.isMyLocation
                        ? Text(
                            _isLoading
                                ? "Wird geladen..."
                                : "Aktueller Standort",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                height: 0,
                                fontWeight: FontWeight.w600),
                          )
                        : _isLoading
                            ? const Text(
                                "Wird geladen...",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                    height: 0,
                                    fontWeight: FontWeight.w600),
                              )
                            : Row(
                                children: [
                                  const SFIcon(
                                    SFIcons.sf_clock,
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  Text(
                                    " ${_localTime ?? 'N/A'}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        height: 0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: 200,
                    child: Text(
                      _isLoading ? "" : (_condition ?? "N/A"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          height: 0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _currentTemp != null
                                ? "${_currentTemp!.toStringAsFixed(0)}°"
                                : "N/A",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 33,
                                height: 0,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.end,
                          ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      _isLoading
                          ? ""
                          : (_maxTemp != null && _minTemp != null)
                              ? "H: ${_maxTemp!.toStringAsFixed(0)}° T: ${_minTemp!.toStringAsFixed(0)}°"
                              : "N/A",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_sficon/flutter_sficon.dart';

// class PlacesCardWidgetWIdget extends StatefulWidget {
//   const PlacesCardWidgetWIdget({
//     super.key,
//     required this.text,
//     required this.placeName,
//     required this.time,
//     required this.condition,
//     required this.currentTemp,
//     required this.maxTemp,
//     required this.minTemp,
//   });

//   final String text;
//   final String placeName;
//   final String time;
//   final String condition;
//   final double currentTemp;
//   final double maxTemp;
//   final double minTemp;

//   @override
//   State<PlacesCardWidgetWIdget> createState() => _PlacesCardWidgetWIdgetState();
// }

// class _PlacesCardWidgetWIdgetState extends State<PlacesCardWidgetWIdget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: Container(
//         width: double.infinity,
//         height: 100,
//         decoration: BoxDecoration(
//             image: const DecorationImage(
//                 image: AssetImage("assets/images/wolken_card.jpeg"),
//                 fit: BoxFit.fill),
//             borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     width: 200,
//                     child: Text(
//                       widget.text,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 15,
//                           height: 0,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   SizedBox(
//                     width: 200,
//                     child: widget.text == "Mein Standort"
//                         ? Text(
//                             widget.placeName,
//                             style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 height: 0,
//                                 fontWeight: FontWeight.w600),
//                           )
//                         : Row(
//                             children: [
//                               const SFIcon(
//                                 SFIcons.sf_clock_arrow_2_circlepath,
//                                 color: Colors.white,
//                                 fontSize: 10,
//                               ),
//                               Text(
//                                 " ${widget.time}",
//                                 style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10,
//                                     height: 0,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                   ),
//                   const Expanded(child: SizedBox()),
//                   SizedBox(
//                     width: 200,
//                     child: Text(
//                       widget.condition,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           height: 0,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 100,
//                     child: Text(
//                       "${widget.currentTemp}°",
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 33,
//                           height: 0,
//                           fontWeight: FontWeight.w300),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 100,
//                     child: Text(
//                       "H: ${widget.maxTemp}° T: ${widget.minTemp}°",
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
