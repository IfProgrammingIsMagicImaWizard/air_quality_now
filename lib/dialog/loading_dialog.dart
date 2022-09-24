import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals/style.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFc4e0f3),
      shape: dialogShape(),
      content: Container(
        color: const Color(0xFFc4e0f3),
        child: const CupertinoActivityIndicator(
          color: Color(0xFFFFFFFF),
          radius: 50,
        ),
      ),
    );
  }
}
