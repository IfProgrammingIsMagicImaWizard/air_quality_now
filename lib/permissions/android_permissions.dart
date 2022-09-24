import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as gps;

import '../models/setup.dart';

Future<bool> requestPermission(
    {required Permission permission,
    required Widget dialog,
    required BuildContext context}) async {
  if (Platform.isAndroid && await permission.isGranted == false) {
    await Permission.storage.request();
  }
  if (Platform.isAndroid && await permission.isDenied) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return dialog;
        });
    return false;
  }
  return true;
}

Future<Setup> useGps(String token) async {
  Location location = Location();

  bool? serviceEnabled;
  gps.PermissionStatus? permissionGranted;
  LocationData? locationData;

  serviceEnabled = await location.serviceEnabled();
  if (serviceEnabled == false) {
    serviceEnabled = await location.requestService();
    if (serviceEnabled == false) {
      openAppSettings();
      return Setup(token: token, latitude: '', longitude: '');
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == gps.PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != gps.PermissionStatus.granted) {
      openAppSettings();
      return Setup(token: token, latitude: '', longitude: '');
    }
  }
  locationData = await location.getLocation();
  return Setup(
      token: token,
      latitude: locationData.latitude.toString(),
      longitude: locationData.longitude.toString());
}
