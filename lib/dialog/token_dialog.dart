import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/little_white_button.dart';
import '../components/small_title.dart';
import '../globals/style.dart';

class TokenDialog extends StatelessWidget {
  const TokenDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: dialogShape(),
      title: const SmallTitle("Token"),
      content: text,
      actions: [
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
      TextSpan(style: textStyle(), text: '${"Generate your Token at".tr()}:'),
      TextSpan(
          style: textLinkStyle2(),
          text: "\n\n www.aqicn.org/\ndata-platform/token/",
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final Uri url =
                  Uri.parse('https://aqicn.org/data-platform/token/');
              launchUrl(url);
            }),
    ]));
