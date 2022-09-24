import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/small_title.dart';
import '../globals/style.dart';
import '../components/little_white_button.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: dialogShape(),
      title: const SmallTitle("Error"),
      content: getText(message),
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

RichText getText(String status) {
  return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            style: textStyle(),
            text: "${'Check your connection or your data'.tr()}."),
        TextSpan(style: textBoldStyle(), text: '\n\n$status'),
      ]));
}
