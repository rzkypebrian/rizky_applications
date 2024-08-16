import 'package:enerren/component/multipleImagePickerComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {

  void commit() {
    notifyListeners();
  }
}

class AbsentModel {
  MultipleImagePickerController multipleImagePickerController =
      new MultipleImagePickerController();
  bool fuelLevel = false;
  bool engineTemperature = false;
  bool oilLevel = false;
  bool batteraiStatus = false;
  bool confirm = false;

  AbsentModel();
}
