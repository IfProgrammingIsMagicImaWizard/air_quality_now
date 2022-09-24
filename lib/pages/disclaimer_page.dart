import 'package:air_quality/components/carousel_with_indicator.dart';
import 'package:air_quality/components/loading.dart';
import 'package:air_quality/json_utilities/setting_json_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/big_main_button.dart';
import '../components/scrollable_view.dart';
import '../components/windows_custom_bar.dart';
import '../dialog/storage_dialog.dart';
import '../components/big_title.dart';
import '../manager/settings.dart';
import '../globals/style.dart';
import '../permissions/android_permissions.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowsCustomBar(
      child: ScrollableView(
        child: Container(
          decoration: BoxDecoration(
            image: lightBackgroud(),
          ),
          child: Padding(
            padding: appPading(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BigTitle("Disclaimer"),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 24.0,
                  ),
                  child: getText(),
                ),
                BigMainButton(
                    text: "Continue".tr(),
                    onPressed: checkPermission(
                        context: context,
                        dialog: const StorageDialog(),
                        permission: Permission.storage)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Function checkPermission(
    {required Permission permission,
    required Widget dialog,
    required BuildContext context}) {
  return () async {
    final navigator = Navigator.of(context);
    if (await requestPermission(
        context: context,
        dialog: const StorageDialog(),
        permission: Permission.storage)) {
      showLoading(context);
      dismissDisclaimer().then((_) => jsonLoadSettings().then((_) {
            popLoading(context);
            navigator.push(MaterialPageRoute(
                builder: (context) => const CarouselWithIndicator(
                      isFirstTime: true,
                    )));
          }));
    }
  };
}

RichText getText() {
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(style: textStyle(), text: "Disclaimer".tr()),
        TextSpan(
            style: textLinkStyle(),
            text: "\n\n https://waqi.info/",
            recognizer: TapGestureRecognizer()..onTap = () async {}),
        TextSpan(
          style: textStyle(),
          text: "\n\n Backgroud image provided by ",
        ),
        TextSpan(
          text: "rawpixel.com",
          style: textBoldStyle(),
        ),
        TextSpan(
          text: " at ",
          style: textStyle(),
        ),
        TextSpan(
          text: "freepik.com",
          style: textBoldStyle(),
        ),
      ]));
}
