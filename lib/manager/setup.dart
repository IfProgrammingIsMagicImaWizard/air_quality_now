import 'dart:async';

import '../manager/settings.dart';
import '../models/air_quality_info.dart';
import '../components/air_quality_card.dart';
import '../http/webclients/air_quality_webclient.dart';
import '../models/setup.dart';
import '../json_utilities/setup_files_manager.dart';
import 'auto_update_setups.dart';
import 'notification.dart';

Map<String, Setup> managerSetups = {};

String lastValidToken() {
  return managerSettings.lastValidToken ?? "";
}

Future<Setup> saveSetup(Setup setup, {bool isStartUp = false}) async {
  setup = await loadApi(setup, newEntry: isNewEntry(setup.id));
  int statusCode = setup.statusCode;
  if (statusCode == 200) {
    managerSetups[setup.id] = setup;
    jsonSaveSetups(_setupsTojson());
    autoUpdateSetup(setup);
  }
  saveLastValidToken(setup.token);
  if (isStartUp == false) {
    sendNotification(setup);
  }
  return setup;
}

bool isNewEntry(String id) {
  return !managerSetups.containsKey(id);
}

get getGlobalSetups => managerSetups;

get globalSetupsIsEmpty => managerSetups.isEmpty;

Map<String, Map<String, dynamic>> _setupsTojson() {
  Map<String, Map<String, dynamic>> out = {};
  for (Setup i in managerSetups.values) {
    out[i.id] = i.toJson();
  }
  return out;
}

List<AirQualityCard> generateCards() {
  List<AirQualityCard> cards = [];
  for (Setup i in managerSetups.values) {
    AirQualityInfo? info = i.info;
    if (info != null) {
      StreamController<Setup> streamController =
          states[i.id] ?? StreamController<Setup>.broadcast();
      cards.add(AirQualityCard(
        i,
        stream: streamController.stream,
      ));
      states[i.id] = streamController;
    }
  }
  return cards;
}

void updateSetupsOrder(List<Setup> setups) {
  Map<String, Setup> map = {};
  for (Setup i in setups) {
    map[i.id] = i;
  }
  managerSetups = map;
  jsonSaveSetups(_setupsTojson());
}

void setGlobalSetups(Map<String, Setup> setups) {
  managerSetups = setups;
}

Future<bool> deleteSetup(Setup i) {
  if (managerSetups.containsKey(i.id)) {
    managerSetups.remove(i.id);
    cancelTimer(i);
    timers.remove(i.id);
    states.remove(i.id);
  }
  return jsonSaveSetups(_setupsTojson());
}

void onOpenUpdateCards() {
  if (globalSetupsIsEmpty == false) {
    for (Setup i in managerSetups.values) {
      saveSetup(i, isStartUp: true);
    }
  }
}
