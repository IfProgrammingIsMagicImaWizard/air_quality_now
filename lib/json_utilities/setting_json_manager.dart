import 'dart:io';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../manager/auto_change_theme.dart';
import '../models/settings.dart';
import '../manager/settings.dart';
import 'json_manager.dart';

String fileName = "air_quality_settings.json";

Future<bool> jsonSaveSettings(Settings settings) async {
  try {
    final documents = await directoryPath;
    final folder = Directory('$documents/$folderName');
    bool isFolder = await checkDirectory('/$folderName');
    if (isFolder) {
      File file = File('${folder.path}/$fileName');
      file.writeAsStringSync(json.encode(settings.toJson()));
      log("File '$fileName' saved at '${folder.path}'");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return true;
}

Future<bool> jsonLoadSettings() async {
  bool isStorageAllowed = true;

  if (Platform.isAndroid) {
    isStorageAllowed == await Permission.storage.isGranted;
  }
  if (isStorageAllowed) {
    if (await isJson(fileName)) {
      managerSettings = Settings.fromJson(await loadJson(fileName));
      log('File "$fileName" loaded successfully');
    }
  }
  setThemeOnOpen();
  return true;
}
