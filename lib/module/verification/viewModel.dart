import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/timerCountDownComponent.dart';
import 'package:flutter/material.dart';
import '../../model/ginotaModel.dart' as ginota;

class ViewModel extends ChangeNotifier {
  bool onLoading = false;
  bool startTimer = true;
  String errorMessage = "";
  String pin;
  List<String> pinSugest = [];
  bool isValid;
  DateTime requestDate;

  ginota.GinotaModel ginotaModel;

  String verificationCode;

  CircularProgressIndicatorController loadingController =
      CircularProgressIndicatorController();

  TimerCountDownController timerCountDownController =
      new TimerCountDownController();

  List<String> pins = [];
  List<StateInput> pinsSate = [];
  int activePins = 0;

  void clearPin(int length) {
    pins = List.generate(
      length,
      (index) {
        return "";
      },
    );
    pinsSate = List.generate(
      length,
      (index) {
        return StateInput.Enable;
      },
    );
    pin = "";
    activePins = 0;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
