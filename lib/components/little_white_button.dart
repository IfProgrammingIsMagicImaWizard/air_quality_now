import 'package:flutter/material.dart';

import '../globals/style.dart';

class LittleWhiteButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const LittleWhiteButton(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: Colors.black.withOpacity(0.25),
          ),
          primary: const Color(0xffF3F5F7),
          minimumSize: const Size.fromHeight(43),
        ),
        onPressed: () => onPressed(),
        child: Text(
          text,
          style: textWhiteButtonStyle(),
        ),
      ),
    );
  }
}
