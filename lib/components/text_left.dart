import 'package:flutter/material.dart';

class TextLeft extends StatelessWidget {
  final Text tchild;
  const TextLeft(this.tchild, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: tchild);
  }
}
