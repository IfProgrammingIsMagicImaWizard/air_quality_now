import 'package:flutter/material.dart';

import '../globals/style.dart';

class BigMainButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BigMainButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: mainColor,
          minimumSize: const Size.fromHeight(56),
          side: BorderSide(
            width: 1.0,
            color: Colors.white.withOpacity(0.25),
          ),
        ),
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
