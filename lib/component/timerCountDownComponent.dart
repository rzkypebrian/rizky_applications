import 'dart:async';
import 'package:flutter/material.dart';

typedef TimerContainer = Widget Function(TimerCountDown timerCountDown);

///branch component_timerCountDownComponent
class TimerCountDownComponent extends StatelessWidget {
  final TimerCountDownController controller;
  final TimerContainer child;

  const TimerCountDownComponent({
    Key key,
    this.controller,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TimerCountDown>(
        valueListenable: controller,
        builder: (context, value, c) {
          return child != null ? child(value) : defaultContainer(value);
        });
  }

  Widget defaultContainer(TimerCountDown timerCountDown) {
    return Container(
      child: Text(
          "isRunning ${timerCountDown.isRunning} ${timerCountDown.days} : ${timerCountDown.hours} : ${timerCountDown.minutes} : ${timerCountDown.second} : ${timerCountDown.miliSecond}"),
    );
  }
}

class TimerCountDown {
  Duration duration;
  bool isRunning;

  int get days => duration.inDays;
  int get hours => duration.inHours - Duration(days: duration.inDays).inHours;
  int get minutes =>
      duration.inMinutes - Duration(hours: duration.inHours).inMinutes;
  int get second =>
      duration.inSeconds - Duration(minutes: duration.inMinutes).inSeconds;
  int get miliSecond =>
      duration.inMilliseconds -
      Duration(seconds: duration.inSeconds).inMilliseconds;

  TimerCountDown({
    this.duration,
    this.isRunning = false,
  });
}

class TimerCountDownController extends ValueNotifier<TimerCountDown> {
  TimerCountDownController([TimerCountDown timerCountDown])
      : super(timerCountDown == null
            ? TimerCountDown(duration: Duration(seconds: 60))
            : timerCountDown);

  Duration _duration;
  Timer _timer;

  void start({
    VoidCallback onTick,
  }) {
    _duration = value.duration;
    value.isRunning = true;
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(
      period,
      (t) {
        if (value.duration.inSeconds > 0) {
          value.duration = Duration(
            seconds: (value.duration.inSeconds - 1),
          );
          if (onTick != null) {
            onTick();
          }
          notifyListeners();
        } else {
          _timer.cancel();
        }
      },
    );
  }

  void pause() {
    value.isRunning = false;
    _timer.cancel();
    notifyListeners();
  }

  void reset({Duration duration}) {
    value.duration = duration ?? _duration;
    notifyListeners();
  }
}
