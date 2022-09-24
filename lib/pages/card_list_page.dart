import 'package:flutter/material.dart';

import '../components/card_list.dart';
import '../components/classification_bar.dart';
import '../components/windows_custom_bar.dart';
import '../globals/style.dart';
import '../manager/settings.dart';
import 'setup_page.dart';

class CardListPage extends StatelessWidget {
  const CardListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowsCustomBar(
      allowDarkMode: true,
      child: Scaffold(
        backgroundColor:
            (managerSettings.hideBackground) ? Colors.transparent : null,
        body: Stack(children: [
          const Positioned(
            top: 0,
            left: 0,
            child: CardList(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: (managerSettings.showClassificationBar)
                ? const ClassificationBar()
                : const SizedBox(),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SetupPage()));
          },
          backgroundColor: mainColor,
          child: const Icon(
            Icons.add,
            size: 24,
          ),
        ),
      ),
    );
  }
}
