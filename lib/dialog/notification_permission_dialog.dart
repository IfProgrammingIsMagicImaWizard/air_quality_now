import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/little_main_button.dart';
import '../components/little_white_button.dart';
import '../components/small_title.dart';
import '../globals/style.dart';

class NotificationPermissionDialog extends StatelessWidget {
  const NotificationPermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: dialogShape(),
      title: SmallTitle("Permission".tr()),
      content: getText(),
      actions: [
        LittleMainButton(
            text: 'AppSettings',
            onPressed: () {
              openAppSettings();
            }),
        LittleWhiteButton(
            text: "Ok",
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}

RichText getText() {
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            style: textStyle(),
            text:
                "You have blocked access to notifications, change it on device settings."
                    .tr()),
      ]));
}
