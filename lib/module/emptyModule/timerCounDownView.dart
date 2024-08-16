import 'package:enerren/component/timerCountDownComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'presenter.dart';

class TimerCountDownView extends PresenterState {
  TimerCountDownController timerCountDownController =
      new TimerCountDownController(
          TimerCountDown(duration: Duration(milliseconds: 8123764239)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          ModeUtil.debugPrint("start");
          if (timerCountDownController.value.isRunning) {
            timerCountDownController.pause();
          } else {
            timerCountDownController.start();
          }
        },
        child: Center(
          child: Container(
            height: 500,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    ModeUtil.debugPrint("reset");
                    timerCountDownController.reset();
                  },
                  child: Text("reset"),
                ),
                TimerCountDownComponent(
                  controller: timerCountDownController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
