import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/small_title.dart';
import '../globals/style.dart';
import '../pages/card_list_page.dart';
import '../components/little_white_button.dart';

class ScheduledDialog extends StatelessWidget {
  const ScheduledDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: dialogShape(),
      title: SmallTitle("Scheduled".tr()),
      content: text,
      actions: [
        LittleWhiteButton(
            text: "Ok",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CardListPage()));
            })
      ],
    );
  }
}

RichText text = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: [
      TextSpan(
          style: textStyle(),
          text:
              "The stations on this location are closed, outside opening hours. The card will be updated as soon it opens."
                  .tr()),
    ]));
