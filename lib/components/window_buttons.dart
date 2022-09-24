import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  final Color iconNormalColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(iconNormal: iconNormalColor),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(iconNormal: iconNormalColor),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(iconNormal: iconNormalColor),
        )
      ],
    );
  }
}
