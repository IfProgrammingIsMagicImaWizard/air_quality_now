import 'package:uuid/uuid.dart';

import 'air_quality_info.dart';
import 'notification_options.dart';

class Setup {
  final String? _id;
  final String token;
  final String latitude;
  final String longitude;
  final AirQualityInfo? info;
  final int statusCode;
  final String status;
  final bool isOnline;
  final NotificationOptions _notificationOptions;
  Setup({
    String? id,
    required this.token,
    required this.latitude,
    required this.longitude,
    this.info,
    this.statusCode = 99,
    this.status = 'Local Error',
    this.isOnline = false,
    NotificationOptions? notificationOptions,
  })  : _id = id ?? const Uuid().v1(),
        _notificationOptions = notificationOptions ?? NotificationOptions();

  @override
  String toString() {
    return toJson().toString();
  }

  get id => _id;

  get notificationOptions => _notificationOptions;

  copyWith(
      {String? id,
      String? token,
      String? latitude,
      String? longitude,
      AirQualityInfo? info,
      int? statusCode,
      String? status,
      bool? isOnline,
      NotificationOptions? notificationOptions}) {
    return Setup(
      id: id ?? _id,
      token: token ?? this.token,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      info: info ?? this.info,
      statusCode: statusCode ?? this.statusCode,
      status: status ?? this.status,
      isOnline: isOnline ?? this.isOnline,
      notificationOptions: notificationOptions ?? _notificationOptions,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'token': token,
        'latitude': latitude,
        'longitude': longitude,
        'info': (info != null) ? info?.toJson() : null,
        'statusCode': statusCode,
        'status': status,
        'isOnline': isOnline,
        'notificationOptions': _notificationOptions.toJson(),
      };

  Setup.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        token = json['token'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        info = (json['info'] != null)
            ? AirQualityInfo.fromJson(json['info'])
            : null,
        statusCode = json['statusCode'],
        status = json['status'],
        isOnline = json['isOnline'],
        _notificationOptions =
            NotificationOptions.fromJson(json['notificationOptions']);
}
