// class Main {
//   Main({
//     required this.latitude,
//     required this.longitude,
//     required this.generationtimeMs,
//     required this.utcOffsetSeconds,
//     required this.timezone,
//     required this.timezoneAbbreviation,
//     required this.elevation,
//     required this.currentUnits,
//     required this.current,
//     required this.hourlyUnits,
//     required this.hourly,
//     required this.dailyUnits,
//     required this.daily,
//   });

//   final double latitude;
//   final double longitude;
//   final double generationtimeMs;
//   final int utcOffsetSeconds;
//   final String timezone;
//   final String timezoneAbbreviation;
//   final int elevation;
//   final Units currentUnits;
//   final Current current;
//   final Units hourlyUnits;
//   final Hourly hourly;
//   final DailyUnits dailyUnits;
//   final Daily daily;

//   factory Main.fromJson(Map<String, dynamic> json) {
//     return Main(
//       latitude: json['latitude'],
//       longitude: json['longitude'],
//       generationtimeMs: json['generationtime_ms'],
//       utcOffsetSeconds: json['utc_offset_seconds'],
//       timezone: json['timezone'],
//       timezoneAbbreviation: json['timezone_abbreviation'],
//       elevation: json['elevation'],
//       currentUnits: Units.fromJson(json['current_units']),
//       current: Current.fromJson(json['current']),
//       hourlyUnits: Units.fromJson(json['hourly_units']),
//       hourly: Hourly.fromJson(json['hourly']),
//       dailyUnits: DailyUnits.fromJson(json['daily_units']),
//       daily: Daily.fromJson(json['daily']),
//     );
//   }
// }

// class Current {
//   Current({
//     required this.time,
//     required this.interval,
//     required this.temperature2M,
//     required this.precipitation,
//   });

//   final String time;
//   final int interval;
//   final double temperature2M;
//   final int precipitation;

//   factory Current.fromJson(Map<String, dynamic> json) {
//     return Current(
//       time: json['time'],
//       interval: json['interval'],
//       temperature2M: json['temperature_2m'],
//       precipitation: json['precipitation'],
//     );
//   }
// }

// class Units {
//   Units({
//     required this.time,
//     required this.interval,
//     required this.temperature2M,
//     required this.precipitation,
//     required this.precipitationProbability,
//   });

//   final String time;
//   final String interval;
//   final String temperature2M;
//   final String precipitation;
//   final String precipitationProbability;

//   factory Units.fromJson(Map<String, dynamic> json) {
//     return Units(
//       time: json['time'],
//       interval: json['interval'],
//       temperature2M: json['temperature_2m'],
//       precipitation: json['precipitation'],
//       precipitationProbability: json['precipitation_probability'],
//     );
//   }
// }

// class Daily {
//   Daily({
//     required this.time,
//     required this.temperature2MMax,
//     required this.temperature2MMin,
//     required this.precipitationSum,
//     required this.precipitationProbabilityMax,
//   });

//   final List<DateTime> time;
//   final List<double> temperature2MMax;
//   final List<double> temperature2MMin;
//   final List<double> precipitationSum;
//   final List<int> precipitationProbabilityMax;

//   factory Daily.fromJson(Map<String, dynamic> json) {
//     return Daily(
//       time: (json['time'] as List<dynamic>)
//           .map((item) => DateTime.parse(item as String))
//           .toList(),
//       temperature2MMax: (json['temperature_2m_max'] as List<dynamic>)
//           .map((item) => (item as num).toDouble())
//           .toList(),
//       temperature2MMin: (json['temperature_2m_min'] as List<dynamic>)
//           .map((item) => (item as num).toDouble())
//           .toList(),
//       precipitationSum: (json['precipitation_sum'] as List<dynamic>)
//           .map((item) => (item as num).toDouble())
//           .toList(),
//       precipitationProbabilityMax:
//           (json['precipitation_probability_max'] as List<dynamic>)
//               .map((item) => (item as num).toInt())
//               .toList(),
//     );
//   }
// }

// class DailyUnits {
//   DailyUnits({
//     required this.time,
//     required this.temperature2MMax,
//     required this.temperature2MMin,
//     required this.precipitationSum,
//     required this.precipitationProbabilityMax,
//   });

//   final String time;
//   final String temperature2MMax;
//   final String temperature2MMin;
//   final String precipitationSum;
//   final String precipitationProbabilityMax;

//   factory DailyUnits.fromJson(Map<String, dynamic> json) {
//     return DailyUnits(
//       time: json['time'],
//       temperature2MMax: json['temperature_2m_max'],
//       temperature2MMin: json['temperature_2m_min'],
//       precipitationSum: json['precipitation_sum'],
//       precipitationProbabilityMax: json['precipitation_probability_max'],
//     );
//   }
// }

// class Hourly {
//   Hourly({
//     required this.time,
//     required this.temperature2M,
//     required this.precipitationProbability,
//     required this.precipitation,
//   });

//   final List<String> time;
//   final List<double> temperature2M;
//   final List<int> precipitationProbability;
//   final List<double> precipitation;

//   factory Hourly.fromJson(Map<String, dynamic> json) {
//     return Hourly(
//       time: List<String>.from(json['time']),
//       temperature2M: (json['temperature_2m'] as List<dynamic>)
//           .map((item) => (item as num).toDouble())
//           .toList(),
//       precipitationProbability:
//           (json['precipitation_probability'] as List<dynamic>)
//               .map((item) => (item as num).toInt())
//               .toList(),
//       precipitation: (json['precipitation'] as List<dynamic>)
//           .map((item) => (item as num).toDouble())
//           .toList(),
//     );
//   }
// }
