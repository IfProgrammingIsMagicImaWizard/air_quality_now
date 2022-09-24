import 'dart:io' show Platform;

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../components/window_buttons.dart';
import '../manager/auto_change_theme.dart';

class WindowsCustomBar extends StatefulWidget {
  final Widget child;
  final bool allowDarkMode;
  const WindowsCustomBar(
      {this.allowDarkMode = false, required this.child, Key? key})
      : super(key: key);

  @override
  State<WindowsCustomBar> createState() => _WindowsCustomBarState();
}

class _WindowsCustomBarState extends State<WindowsCustomBar> {
  late Color windowsBarColor;
  final Stream<bool> stream = cardListBackgroundState.stream;

  @override
  void initState() {
    super.initState();
    windowsBarColor =
        (widget.allowDarkMode) ? themeColor() : const Color(0xFFc4e0f3);
    stream.listen((i) {
      updateState(i);
    });
  }

  void updateState(bool i) {
    if (!mounted) return;
    setState(() {
      windowsBarColor =
          (widget.allowDarkMode) ? themeColor() : const Color(0xFFc4e0f3);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(color: windowsBarColor),
            child: WindowTitleBarBox(
              child: Row(
                children: [
                  Flexible(flex: 1, child: MoveWindow()),
                  const WindowButtons()
                ],
              ),
            ),
          ),
          Flexible(child: widget.child),
        ],
      );
    } else {
      return widget.child;
    }
  }
}
