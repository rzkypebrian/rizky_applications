import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/AttendanceModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  bool isAccept = false;
  bool readOnly = true;
  bool unfeasible = false;

  AttendanceModel attendanceModel = new AttendanceModel();

  CircularProgressIndicatorController loadingController =
      CircularProgressIndicatorController();

  bool isValidImagePicker = true;

  void unfeasibleValues() {
    this.unfeasible = !this.unfeasible;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
