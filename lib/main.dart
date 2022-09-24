import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_window_close/flutter_window_close.dart';

import '../pages/card_list_page.dart';
import '../pages/setup_page.dart';
import '../json_utilities/setting_json_manager.dart';
import '../globals/style.dart';
import '../manager/settings.dart';
import '../manager/setup.dart';
import '../pages/disclaimer_page.dart';
import '../json_utilities/setup_files_manager.dart';
import '../components/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  jsonLoadSettings().then((_) async {
    if (Platform.isWindows && managerSettings.hideBackground) {
      Window.initialize()
          .then((value) => Window.setEffect(effect: WindowEffect.acrylic));
    }

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(
        AppLocalization(child: Phoenix(child: const MyApp())),
      );
    });
  });
  if (Platform.isWindows) {
    initCustomWindow();
  }
}

void initCustomWindow() {
  return doWhenWindowReady(() {
    final win = appWindow;
    final Size initialSize = managerSettings.size;
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Air Quality Now";
    win.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (Platform.isWindows) {
      FlutterWindowClose.setWindowShouldCloseHandler(() async {
        final Size size = await DesktopWindow.getWindowSize();
        if (managerSettings.size != size) {
          saveSettings(managerSettings.copyWith(size: size));
        }
        final CustomButton answer = await FlutterPlatformAlert.showCustomAlert(
          windowTitle: "",
          text: "Are you sure you want to Exit?".tr(),
          positiveButtonTitle: "Exit".tr(),
          negativeButtonTitle: "Cancel".tr(),
        );
        if (answer == CustomButton.positiveButton) {
          return true;
        }
        return false;
      });

      if (managerSettings.hideBackground) {
        Window.setEffect(effect: WindowEffect.acrylic);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        color: mainColor,
      )),
      scrollBehavior: EnableMouseDragScrollBehavior(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: FutureBuilder<bool>(
          future: jsonLoadSetups(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              onOpenUpdateCards();
              return getHome();
            } else {
              return Container(
                color: const Color(0xFFc4e0f3),
                child: const CupertinoActivityIndicator(
                  color: Color(0xFFFFFFFF),
                  radius: 50,
                ),
              );
            }
          }),
    );
  }
}

Widget getHome() {
  if (managerSettings.dismissDisclaimer == false) {
    return const DisclaimerPage();
  } else if (globalSetupsIsEmpty) {
    return const SetupPage();
  }
  return const CardListPage();
}

class EnableMouseDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

//final helloWorld = 'hello world'.toCapitalized(); // 'Hello world'
//final helloWorld = 'hello world'.toUpperCase(); // 'HELLO WORLD'
//final helloWorldCap = 'hello world'.toTitleCase(); // 'Hello World'

extension Range on num {
  bool isBetween(num from, num to) {
    return from <= this && this <= to;
  }
}
