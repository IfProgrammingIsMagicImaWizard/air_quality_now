import '../models/setup.dart';
import '../services/local_notification_service.dart';
import 'classification.dart';

late final LocalNotificationService service;

void init() {
  service = LocalNotificationService();
  service.intialize();
}

bool isInit = false;

void sendNotification(Setup setup) {
  if (isInit == false) {
    init();
    isInit = true;
  }
  if (setup.notificationOptions!.enableNotification) {
    if (shouldSendNotification(setup)) {
      if (setup.isOnline) {
        service.showNotification(
            id: generateNotificationId(setup),
            title: setup.info!.location,
            body: 'Air Quality: ${getRatingName(setup.info!.score)}');
        lastSent[generateNotificationId(setup)] =
            getRatingEnum(setup.info!.score);
      }
    }
  }
}

Map<int, Rating> lastSent = {};

bool shouldSendNotification(Setup setup) {
  bool isOnUpdate = (setup.notificationOptions!.notify == Rating.onUpdate);
  Rating current = getRatingEnum(setup.info!.score);
  bool isDifferent =
      (lastSent.containsKey(setup.id)) ? (lastSent[setup.id] != current) : true;
  if (isOnUpdate || isDifferent) {
    return true;
  } else {
    return false;
  }
}

int generateNotificationId(Setup setup) {
  double float = double.parse(setup.latitude) - double.parse(setup.longitude);
  return float.round();
}
