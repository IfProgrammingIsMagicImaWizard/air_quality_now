import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocalization extends StatelessWidget {
  final Widget child;
  const AppLocalization({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('pt'),
          Locale('es'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: child);
  }
}
