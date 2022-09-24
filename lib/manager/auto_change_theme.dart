import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';

import '../globals/style.dart';
import '../scheduler/set_scheduler.dart';
import 'auto_update_setups.dart';
import 'settings.dart';

StreamController<bool> cardListBackgroundState =
    StreamController<bool>.broadcast();

Cron? _cron;
SetScheduler? _autoChangeThemeSet;

void _autoChangeThemeTimerInit() {
  if (managerSettings.autoChangeTheme) {
    if (_cron == null) {
      _initCron();
    }
    if (_autoChangeThemeSet == null) {
      _initTimer();
    }
  } else {
    if (_cron != null) {
      _cancelCron();
    }
    if (_autoChangeThemeSet != null) {
      _cancelTimer();
    }
  }
}

void _checkThemeTime() {
  if (managerSettings.autoChangeTheme) {
    if (isDayTime() && managerSettings.darkMode == true) {
      _setDayState();
    } else if (managerSettings.darkMode == false) {
      _setNightState();
    }
  }
}

void _setDayState() async {
  await saveSettings(managerSettings.copyWith(darkMode: false));
  updateCardsState();
  cardListBackgroundState.add(true);
}

void _setNightState() async {
  await saveSettings(managerSettings.copyWith(darkMode: true));
  updateCardsState();
  cardListBackgroundState.add(true);
}

void _initCron() {
  if (_cron == null) {
    _cron = Cron();
    _cron!.schedule(Schedule.parse('0 6 * * *'), () async {
      _setDayState();
    });

    _cron!.schedule(Schedule.parse('0 18 * * *'), () async {
      _setNightState();
    });
  }
}

void _cancelCron() {
  if (_cron != null) {
    _cron!.close();
    _cron = null;
  }
}

void _initTimer() {
  _autoChangeThemeSet = _autoChangeThemeSet ??
      SetScheduler(_checkThemeTime, duration: const Duration(minutes: 30));
}

void _cancelTimer() {
  if (_autoChangeThemeSet != null) {
    _autoChangeThemeSet!.cancel;
    _autoChangeThemeSet = null;
  }
}

void setThemeOnOpen() {
  if (managerSettings.autoChangeTheme) {
    _checkThemeTime();
    _autoChangeThemeTimerInit();
  }
}

bool isDayTime() {
  TimeOfDay startTime = const TimeOfDay(hour: 6, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 18, minute: 0);
  TimeOfDay now = TimeOfDay.now();
  return ((now.hour > startTime.hour) ||
          (now.hour == startTime.hour && now.minute >= startTime.minute)) &&
      ((now.hour < endTime.hour) ||
          (now.hour == endTime.hour && now.minute <= endTime.minute));
}

BoxDecoration getImageBackgroud() {
  if (managerSettings.hideBackground) {
    return const BoxDecoration();
  }
  if ((managerSettings.darkMode && managerSettings.autoChangeTheme == false) ||
      (managerSettings.autoChangeTheme == true && isDayTime() == false)) {
    return BoxDecoration(image: darkBackgroud());
  }
  return BoxDecoration(image: lightBackgroud());
}

Color themeColor() {
  return isDarkTheme() ? const Color(0xFF383685) : const Color(0xFFc4e0f3);
}

bool isDarkTheme() {
  if (managerSettings.autoChangeTheme) {
    return (isDayTime()) ? false : true;
  } else {
    return (managerSettings.darkMode) ? true : false;
  }
}
