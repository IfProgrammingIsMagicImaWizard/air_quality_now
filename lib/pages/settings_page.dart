import 'dart:io' show Platform;

import 'package:air_quality/components/text_left.dart';
import 'package:air_quality/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/windows_custom_bar.dart';
import '../globals/style.dart';
import '../json_utilities/setting_json_manager.dart';
import '../manager/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showClassificationBar = managerSettings.showClassificationBar;
  bool darkMode = managerSettings.darkMode;
  bool hideBackground = managerSettings.hideBackground;
  bool autoChangeTheme = managerSettings.autoChangeTheme;
  bool hasChanged = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Settings settings = managerSettings.copyWith(
            showClassificationBar: showClassificationBar,
            darkMode: darkMode,
            hideBackground: hideBackground,
            autoChangeTheme: autoChangeTheme,
          );
          if (hasChanged) {
            saveSettings(settings).then((_) {
              jsonLoadSettings().then((_) => Phoenix.rebirth(context));
            });
          }
          return true;
        },
        child: WindowsCustomBar(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Settings".tr(),
                textAlign: TextAlign.center,
                style: whiteTitleStyle(),
              ),
            ),
            body: SettingsList(
              sections: [
                SettingsSection(
                  tiles: <SettingsTile>[
                    boolTileShowClassificationBar(),
                    boolTileEnableDarkMode(),
                    boolTileAutoChangeTheme(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  SettingsTile boolTileHideBackgroundImage() {
    return SettingsTile.switchTile(
      onToggle: (value) {
        hasChanged = true;
        setState(() {
          hideBackground = value;
          if (value) {
            darkMode = value;
          }
        });
      },
      initialValue: hideBackground,
      leading: const Icon(Icons.image),
      title: const Text('Hide Background Image'),
      enabled: (Platform.isWindows) ? true : false,
    );
  }

  SettingsTile boolTileAutoChangeTheme() {
    return SettingsTile.switchTile(
      onToggle: (value) {
        hasChanged = true;
        setState(() {
          autoChangeTheme = value;
        });
      },
      initialValue: autoChangeTheme,
      leading: const Icon(Icons.schedule),
      title: TextLeft(Text('Auto Change Theme'.tr())),
    );
  }

  SettingsTile boolTileEnableDarkMode() {
    return SettingsTile.switchTile(
      onToggle: (value) {
        hasChanged = true;
        setState(() {
          darkMode = value;
          if (value == false) {
            hideBackground = value;
          }
        });
      },
      initialValue: darkMode,
      leading: const Icon(Icons.palette),
      title: TextLeft(Text(
        'Enable Dark Mode'.tr(),
      )),
    );
  }

  SettingsTile boolTileShowClassificationBar() {
    return SettingsTile.switchTile(
      onToggle: (value) {
        hasChanged = true;
        setState(() {
          showClassificationBar = value;
        });
      },
      initialValue: showClassificationBar,
      leading: const Icon(Icons.crop_16_9),
      title: TextLeft(Text('Show Classification Bar'.tr())),
    );
  }
}
