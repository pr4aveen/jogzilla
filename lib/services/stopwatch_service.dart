import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchService {
  Stopwatch _stopwatch = Stopwatch();
  Timer _timer;
  final _duration = const Duration(seconds: 1);
  Function timeToDisplayCallback;
  bool disposed = false;

  StopwatchService({@required this.timeToDisplayCallback});

  void dispose() {
    _timer?.cancel();
    _timer = null;
    _stopwatch.stop();
    disposed = true;
  }

  void _keepRunning() {
    if (_stopwatch.isRunning) {
      _startTimer();
    }

    String hours = _stopwatch.elapsed.inHours.toString().padLeft(2, '0');
    String minutes =
        (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0');
    String seconds =
        (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0');

    if (!disposed) {
      timeToDisplayCallback(
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          totalSeconds: _stopwatch.elapsed.inSeconds);
    }
  }

  void _startTimer() {
    _timer = Timer(_duration, _keepRunning);
  }

  void stop() {
    _stopwatch.stop();
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
