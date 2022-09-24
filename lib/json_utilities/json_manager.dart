import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

const String folderName = "Air Quality";

Future<String> get directoryPath async {
  Directory directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<bool> checkDirectory(String path) async {
  final documents = await directoryPath;
  List<String> folders = path.split('/');
  String subFolder = '';
  for (String i in folders) {
    subFolder = "$subFolder/$i";
    Directory dir = Directory("$documents$subFolder/");
    if (await dir.exists() == false) {
      dir.create();
    }
  }
  return true;
}

Future<Map<String, dynamic>> loadJson(String fileName) async {
  final documents = await directoryPath;
  final folder = Directory('$documents/$folderName/');
  File jsonFile = File("${folder.path}$fileName");
  return parseJsonFile(jsonFile);
}

Future<Map<String, dynamic>> parseJsonFile(File file) async {
  return json.decode(file.readAsStringSync());
}

Future<bool> isJson(String fileName) async {
  final documents = await directoryPath;
  final folder = Directory('$documents/$folderName/');
  bool directoryExists = await folder.exists();
  bool fileExists = await File("${folder.path}$fileName").exists();
  if (directoryExists && fileExists) {
    return true;
  }
  return false;
}
