import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  TextEditingController phoneController = new TextEditingController();
  StateInput phoneState;
  FocusNode focusPhone = FocusNode();
  bool validPhone;

  void commit() {
    notifyListeners();
  }
}
