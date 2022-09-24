import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/small_title.dart';
import '../globals/style.dart';
import '../manager/setup.dart';
import '../models/setup.dart';
import '../components/little_main_button.dart';
import '../components/little_white_button.dart';
import '../components/loading.dart';
import '../pages/card_list_page.dart';

class DeleteDialog extends StatelessWidget {
  final Setup setup;
  const DeleteDialog(this.setup, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: dialogShape(),
      title: SmallTitle("Delete".tr()),
      content: text,
      actions: [
        LittleMainButton(
            text: 'Delete'.tr(),
            onPressed: () {
              showLoading(context);
              deleteSetup(setup).then((_) => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CardListPage())));
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

RichText text = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: [
      TextSpan(
          text: "Are you sure you want to delete?".tr(), style: textStyle()),
    ]));
