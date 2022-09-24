import 'package:flutter/material.dart';

import '../globals/style.dart';

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      title,
      style: smallTitleStyle(),
    );
  }
}
