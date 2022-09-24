import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/big_main_button.dart';
import '../components/big_title.dart';
import '../components/windows_custom_bar.dart';
import '../dialog/notification_permission_dialog.dart';
import '../globals/style.dart';
import '../models/air_quality_info.dart';
import '../models/setup.dart';
import '../permissions/android_permissions.dart';
import '../components/big_white_button.dart';
import '../dialog/delete_dialog.dart';
import '../pages/card_list_page.dart';
import 'notification_options.dart';

class EditSetup extends StatelessWidget {
  final Setup setup;
  const EditSetup(this.setup, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CardListPage()));
          return false;
        },
        child: WindowsCustomBar(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                BigTitle(setup.info!.location),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: getText(setup.info!),
                ),
                const Spacer(),
                Visibility(
                  visible: (Platform.isAndroid),
                  child: BigMainButton(
                      text: 'Notification'.tr(),
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        bool isPermitted = await requestPermission(
                          permission: Permission.notification,
                          dialog: const NotificationPermissionDialog(),
                          context: context,
                        );
                        if (isPermitted) {
                          navigator.push(MaterialPageRoute(
                              builder: (context) =>
                                  NotificationOptionsPage(setup)));
                        }
                      }),
                ),
                deleteButton(context: context, setup: setup),
                BigWhiteButton(
                    text: 'Ok',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CardListPage()));
                    }),
              ],
            ),
          ),
        ));
  }
}

Widget deleteButton({required BuildContext context, required Setup setup}) {
  String text = 'Delete'.tr();
  void onPressed() {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return DeleteDialog(setup);
        });
  }

  if (Platform.isAndroid) {
    return BigWhiteButton(
      text: text,
      onPressed: onPressed,
    );
  } else {
    return BigMainButton(
      text: text,
      onPressed: onPressed,
    );
  }
}

RichText getText(AirQualityInfo info) {
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: '${"Last Status Code".tr()}:',
          style: textStyle(),
        ),
        TextSpan(
          text: "\n\n${info.lastStatusCode}",
          style: textBoldStyle(),
        ),
        TextSpan(
          text: "\n\n${'Last Sent'.tr()}:",
          style: textStyle(),
        ),
        TextSpan(
          text: "\n\n${info.dateDetailString}",
          style: textBoldStyle(),
        ),
      ]));
}
