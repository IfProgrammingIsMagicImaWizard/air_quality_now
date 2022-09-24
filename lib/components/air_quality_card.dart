import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../manager/auto_change_theme.dart';
import '../manager/classification.dart';
import '../models/setup.dart';
import '../globals/style.dart';
import '../manager/settings.dart';
import '../pages/edit_setup_page.dart';

class AirQualityCard extends StatefulWidget {
  final Stream<Setup> stream;
  final Setup setup;

  const AirQualityCard(this.setup, {required this.stream, Key? key})
      : super(key: key);

  @override
  State<AirQualityCard> createState() => _AirQualityCardState();
}

class _AirQualityCardState extends State<AirQualityCard> {
  late Setup _setup;
  BoxDecoration onTapDecoration = const BoxDecoration();
  BoxDecoration onTapUpDecoration = const BoxDecoration();
  BoxDecoration onTapDownDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8), color: mainColor.withAlpha(60));
  Color textColor = (isDarkTheme())
      ? Colors.white.withOpacity(0.95)
      : const Color(0xFF46415B);
  Color backgroundColor = (isDarkTheme())
      ? Colors.black.withOpacity(0.25)
      : Colors.black.withOpacity(0.05);

  @override
  void initState() {
    super.initState();
    _setup = widget.setup;
    widget.stream.listen((i) {
      updateState(i);
    });
  }

  void updateState(Setup i) {
    if (!mounted) return;
    setState(() {
      _setup = i;
      onTapDownDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: mainColor.withAlpha(60));
      textColor = (managerSettings.darkMode)
          ? Colors.white.withOpacity(0.95)
          : const Color(0xFF46415B);
      backgroundColor = (managerSettings.darkMode)
          ? Colors.black.withOpacity(0.25)
          : Colors.black.withOpacity(0.05);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: onTapDecoration,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTapDown: (_) async {
              setState(() {
                onTapDecoration = onTapDownDecoration;
              });
            },
            onDoubleTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditSetup(_setup)));
            },
            onTapCancel: () {
              setState(() {
                onTapDecoration = onTapUpDecoration;
              });
            },
            onTapUp: (_) {
              setState(() {
                onTapDecoration = onTapUpDecoration;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: backgroundColor),
              child: Column(children: [
                (_setup.info!.location == '[Scheduled]')
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 8),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _setup.info!.location,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                        color: getRatingColor(_setup.info!.score)),
                    child: Align(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: (_setup.isOnline)
                            ? Text(
                                _setup.info!.score.toString(),
                                style: TextStyle(
                                    color: _scoreColor(_setup.info!.score),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w500),
                              )
                            : const Icon(
                                Icons.schedule,
                                color: Color(0xFF46415B),
                                size: 50.0,
                              ),
                      ),
                    ),
                  ),
                ),
                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      (_setup.isOnline)
                          ? getRatingName(_setup.info!.score)
                          : 'Scheduled'.tr(),
                      style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${"Updated on".tr()} ${_setup.info!.dateString}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: (managerSettings.darkMode)
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

Color _scoreColor(int score) {
  if (isModerate(score)) {
    return const Color(0xFF46415B);
  } else {
    return Colors.white;
  }
}
