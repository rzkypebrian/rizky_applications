import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class Viewer extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  List<TripAllowanceSummary> doModelList = [];

  void commit() {
    notifyListeners();
  }
}
