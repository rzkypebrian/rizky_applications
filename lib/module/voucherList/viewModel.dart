import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<TmsVoucherModel> vouchers = [];
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  ViewModel();

  void commit() {
    notifyListeners();
  }
}
