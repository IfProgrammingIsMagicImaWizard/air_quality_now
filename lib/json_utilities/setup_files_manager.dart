import 'dart:io';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../manager/setup.dart';
import '../models/setup.dart';
import 'json_manager.dart';

String fileName = "air_quality_setups.json";

Future<bool> jsonSaveSetups(Map<String, Map<String, dynamic>> map) async {
  try {
    final documents = await directoryPath;
    final folder = Directory('$documents/$folderName');
    bool isFolder = await checkDirectory('/$folderName');
    if (isFolder) {
      File file = File('${folder.path}/$fileName');
      file.writeAsStringSync(json.encode(map));
      log("File '$fileName' saved at '${folder.path}'");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return true;
}

Future<bool> jsonLoadSetups() async {
  bool isStorageAllowed = true;

  if (Platform.isAndroid) {
    isStorageAllowed == await Permission.storage.isGranted;
  }
  if (isStorageAllowed) {
    if (await isJson(fileName)) {
      setGlobalSetups(_converter(await loadJson(fileName)));
      log('File "$fileName" loaded successfully');
    }
  }
  return true;
}

Map<String, Setup> _converter(Map<String, dynamic> json) {
  Map<String, Setup> out = {};
  for (var i in json.values) {
    Setup temp = Setup.fromJson(i);
    out[temp.id] = temp;
  }
  return out;
}
