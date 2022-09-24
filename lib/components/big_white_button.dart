import 'package:flutter/material.dart';

import '../globals/style.dart';

class BigWhiteButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BigWhiteButton({required this.text, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: buttonPadding(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color(0xffF3F5F7),
          minimumSize: const Size.fromHeight(56),
          side: BorderSide(
            width: 1.0,
            color: Colors.black.withOpacity(0.25),
          ),
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
