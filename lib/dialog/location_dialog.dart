import 'dart:io' show Platform;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/little_main_button.dart';
import '../components/loading.dart';
import '../components/small_title.dart';
import '../globals/style.dart';
import '../pages/setup_page.dart';
import '../permissions/android_permissions.dart';
import '../components/little_white_button.dart';

class LocationDialog extends StatelessWidget {
  final String token;
  const LocationDialog(this.token, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return AlertDialog(
      shape: dialogShape(),
      title: SmallTitle("Location".tr()),
      content: text,
      actions: [
        (Platform.isAndroid)
            ? LittleMainButton(
                text: "Allow GPS".tr(),
                onPressed: () async {
                  showLoading(context);
                  useGps(token).then((setup) {
                    popLoading(context);
                    navigator.push(MaterialPageRoute(
                        builder: (context) => SetupPage(setup: setup)));
                  });
                })
            : const SizedBox(),
        LittleWhiteButton(
            text: "Ok",
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}

RichText text = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: [
      TextSpan(style: textStyle(), text: "Search for the coordinates:".tr()),
      TextSpan(
          style: textLinkStyle2(),
          text: "\n\n gps-coordinates.net",
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final Uri url = Uri.parse('https://www.gps-coordinates.net/');
              launchUrl(url);
            }),
      (Platform.isAndroid)
          ? TextSpan(
              style: textStyle(),
              text: "\n\n ${'Or use your phone\'s GPS'.tr()}.")
          : const TextSpan(),
    ]));
