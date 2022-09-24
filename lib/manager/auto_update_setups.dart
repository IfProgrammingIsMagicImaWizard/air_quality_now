import 'dart:async';

import '../models/setup.dart';
import '../scheduler/set_scheduler.dart';
import 'setup.dart';

Map<String, SetScheduler> timers = {};

Map<String, StreamController<Setup>> states = {};

void updateCardsState() {
  if (states.isNotEmpty) {
    for (String key in states.keys) {
      states[key]!.add(managerSetups[key]!);
    }
  }
}



void autoUpdateSetup(Setup setup) {
  if (timers.containsKey(setup.id) == false) {
    timers[setup.id] = SetScheduler(() => saveSetup(managerSetups[setup.id]!));
  }
  if (states.containsKey(setup.id)) {
    states[setup.id]!.add(setup);
  }
}

void cancelTimer(Setup i) {
  timers[i.id]!.cancel;
  timers.remove(i.id);
}
