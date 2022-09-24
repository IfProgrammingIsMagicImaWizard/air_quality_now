import '../manager/classification.dart';

class NotificationOptions {
  final bool enableNotification;
  final bool enableVibration;
  final Rating? notify;

  NotificationOptions({
    this.enableNotification = false,
    this.enableVibration = false,
    this.notify = Rating.onUpdate,
  });

  copyWith({
    bool? enableNotification,
    bool? enableVibration,
    Rating? notify,
  }) {
    return NotificationOptions(
      enableNotification: enableNotification ?? this.enableNotification,
      enableVibration: enableVibration ?? this.enableVibration,
      notify: notify ?? this.notify,
    );
  }

  Map<String, dynamic> toJson() => {
        'enableNotification': enableNotification,
        'enableVibration': enableVibration,
        'notify': ratingName[notify],
      };

  NotificationOptions.fromJson(Map<String, dynamic> json)
      : enableNotification = json['enableNotification'],
        enableVibration = json['enableVibration'],
        notify = ratingEnum[json['notify']];
}
