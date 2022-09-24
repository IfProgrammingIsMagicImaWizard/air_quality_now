import 'package:flutter/material.dart';

import '../dialog/loading_dialog.dart';

showLoading(BuildContext context) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (contextDialog) {
        return const LoadingDialog();
      });
}

void popLoading(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
