import 'package:intl/intl.dart';

import '../main.dart';

class AirQualityInfo {
  final String location;
  final int score;
  final DateTime date;
  final String lastStatusCode;

  AirQualityInfo({
    required this.location,
    required this.score,
    DateTime? date,
    required this.lastStatusCode,
  }) : date = date ?? DateTime.now();

  get dateString {
    return '${DateFormat('EEEE').format(date).toTitleCase()} ${DateFormat('h:mm a').format(date)}';
  }

  get dateDetailString {
    return '${DateFormat('y-MM-dd').format(date)}    ${DateFormat('h:mm a').format(date)}';
  }

  copyWith({
    String? location,
    int? score,
    DateTime? date,
    String? lastStatusCode,
  }) {
    return AirQualityInfo(
      location: location ?? this.location,
      score: score ?? this.score,
      date: date ?? this.date,
      lastStatusCode: lastStatusCode ?? this.lastStatusCode,
    );
  }

  Map<String, dynamic> toJson() => {
        'location': location,
        'score': score,
        'date': DateFormat("y-MM-dd HH:mm:ss:mmm").format(date),
        'lastStatusCode': lastStatusCode,
      };

  AirQualityInfo.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        score = json['score'],
        date = DateFormat("y-MM-dd HH:mm:ss:mmm").parse(json['date']),
        lastStatusCode = json['lastStatusCode'];
}
