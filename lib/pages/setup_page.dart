import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../components/big_white_button.dart';
import '../components/windows_custom_bar.dart';
import '../globals/style.dart';
import '../components/setup_form.dart';
import '../components/scrollable_view.dart';
import '../models/setup.dart';
import 'card_list_page.dart';
import 'settings_page.dart';

class SetupPage extends StatelessWidget {
  final Setup? setup;
  const SetupPage({this.setup, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const CardListPage()));
        return Future.value(false);
      },
      child: WindowsCustomBar(
        child: ScrollableView(
          appbar: AppBar(
            centerTitle: true,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Setup".tr(),
                textAlign: TextAlign.center,
                style: whiteTitleStyle(),
              ),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: lightBackgroud(),
            ),
            child: Padding(
                padding: appPading(),
                child: Column(
                  children: [
                    SetupForm(setup),
                    BigWhiteButton(
                        text: "Settings".tr(),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                        }),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
