import 'package:flutter/material.dart';

import '../globals/style.dart';

class SquareButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const SquareButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: mainColor,
        minimumSize: const Size.fromHeight(37),
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: const TextStyle(fontSize: 45),
      ),
    );
  }
}
