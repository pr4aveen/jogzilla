import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchService {
  Stopwatch _stopwatch = Stopwatch();
  final _duration = const Duration(seconds: 1);
  Function timeToDisplayCallback;

  StopwatchService({@required this.timeToDisplayCallback});

  void _keepRunning() {
    if (_stopwatch.isRunning) {
      _startTimer();
    }

    String hours = _stopwatch.elapsed.inHours.toString().padLeft(2, '0');
    String minutes =
        (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
    String seconds =
        (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');

    timeToDisplayCallback(
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        totalSeconds: _stopwatch.elapsed.inSeconds);
  }

  void _startTimer() {
    Timer(_duration, _keepRunning);
  }

  void toggleStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
      _startTimer();
    }
  }
}
