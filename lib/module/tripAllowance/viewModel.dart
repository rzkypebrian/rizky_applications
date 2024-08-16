import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  TripAllowanceSummary exspensesListView = new TripAllowanceSummary();

  void commit() {
    notifyListeners();
  }
}
