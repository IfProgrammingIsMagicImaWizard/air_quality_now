import 'dart:async';
import 'dart:io' show Platform;

import '../models/settings.dart';
import '../json_utilities/setting_json_manager.dart';

Settings managerSettings = Settings(
  darkMode: false,
  showClassificationBar: true,
  hideBackground: false,
  dismissDisclaimer: false,
  autoChangeTheme: true,
);

Future<bool> dismissDisclaimer() {
  if (managerSettings.dismissDisclaimer == false) {
    return jsonSaveSettings(managerSettings.copyWith(dismissDisclaimer: true));
  } else {
    return Future<bool>.value(false);
  }
}

Future<bool> saveLastValidToken(String token) {
  if (managerSettings.lastValidToken != token) {
    managerSettings = managerSettings.copyWith(lastValidToken: token);
    return saveSettings(managerSettings);
  }
  return Future<bool>.value(false);
}

Future<bool> saveSettings(Settings settings) {
  if (Platform.isAndroid) {
    settings = settings.copyWith(hideBackground: false);
  }
  managerSettings = settings;
  return jsonSaveSettings(settings);
}
