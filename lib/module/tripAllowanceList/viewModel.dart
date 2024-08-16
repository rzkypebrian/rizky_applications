import 'package:enerren/component/InputComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TabController controller;
  int indexController = 0;
  InputComponentTextEditingController shimenpNumber =
      new InputComponentTextEditingController();

  void commint() {
    notifyListeners();
  }
}
