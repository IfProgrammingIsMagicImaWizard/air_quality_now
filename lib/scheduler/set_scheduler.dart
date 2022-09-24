import 'dart:async';

import 'package:uuid/uuid.dart';

class SetScheduler {
  final id = const Uuid().v1();
  final Function function;
  final Timer _timer;
  final Duration duration;

  SetScheduler(
    this.function, {
    this.duration = const Duration(hours: 1),
  }) : _timer = Timer.periodic(duration, (Timer t) {
          function();
        });

  get cancel {
    _timer.cancel();
    return true;
  }
}
