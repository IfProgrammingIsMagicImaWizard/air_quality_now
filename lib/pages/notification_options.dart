import 'package:air_quality/components/text_left.dart';
import 'package:air_quality/dialog/notification_radio_dialog.dart';
import 'package:air_quality/manager/classification.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/windows_custom_bar.dart';
import '../globals/style.dart';
import '../manager/setup.dart';
import '../models/notification_options.dart';
import '../models/setup.dart';
import 'edit_setup_page.dart';

class NotificationOptionsPage extends StatefulWidget {
  final Setup setup;
  const NotificationOptionsPage(this.setup, {Key? key}) : super(key: key);

  @override
  State<NotificationOptionsPage> createState() =>
      _NotificationOptionsPageState();
}

class _NotificationOptionsPageState extends State<NotificationOptionsPage> {
  late bool enableNotification;
  late bool enableVibration;
  late Rating notify;
  bool hasChanged = false;

  @override
  void initState() {
    super.initState();
    enableNotification = widget.setup.notificationOptions!.enableNotification;
    enableVibration = widget.setup.notificationOptions!.enableVibration;
    notify = widget.setup.notificationOptions!.notify!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (hasChanged) {
            NotificationOptions notificationOptions = NotificationOptions(
              enableNotification: enableNotification,
              enableVibration: enableVibration,
              notify: notify,
            );
            Setup setup =
                widget.setup.copyWith(notificationOptions: notificationOptions);
            saveSetup(setup, isStartUp: true);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditSetup(setup)));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditSetup(widget.setup)));
          }
          return false;
        },
        child: WindowsCustomBar(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.setup.info!.location,
                  textAlign: TextAlign.center,
                  style: whiteTitleStyle(),
                ),
              ),
              body: SettingsList(
                sections: [
                  SettingsSection(
                    tiles: <SettingsTile>[
                      boolTileEnableNotification(),
                      navigationTiteNotificationRadio(),
                      boolTileEnableVibration(),
                    ],
                  ),
                ],
              )),
        ));
  }

  SettingsTile boolTileEnableNotification() {
    return SettingsTile.switchTile(
      initialValue: enableNotification,
      leading: const Icon(Icons.notifications),
      title: TextLeft(Text('Enable Notification'.tr())),
      onToggle: (value) {
        hasChanged = true;
        setState(() {
          enableNotification = value;
        });
      },
    );
  }

  SettingsTile boolTileEnableVibration() {
    return SettingsTile.switchTile(
      enabled: enableNotification,
      initialValue: enableVibration,
      leading: const Icon(Icons.vibration),
      title: TextLeft(Text('Enable Vibration'.tr())),
      onToggle: (value) {
        hasChanged = true;
        setState(() {
          enableVibration = value;
        });
      },
    );
  }

  SettingsTile navigationTiteNotificationRadio() {
    return SettingsTile.navigation(
      leading: const Icon(Icons.priority_high),
      title: TextLeft(Text('Notify'.tr())),
      value: Text(ratingName[notify]!.tr()),
      enabled: enableNotification,
      onPressed: (context) {
        hasChanged = true;
        showDialog(
            context: context,
            builder: (contextDialog) {
              return const NotificationRadioDialog();
            }).then((value) => setState(() {
              notify = value;
            }));
      },
    );
  }
}
