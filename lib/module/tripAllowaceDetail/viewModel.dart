import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TabController controller;
  int indexController = 0;
  TripAllowanceSummary tripAllowanceSummary;
  List<TripAllowanceSummary> tripAllowanceSummaryList = [];

  void addBudget() {
    tripAllowanceSummaryList.add(tripAllowanceSummary);
    commint();
  }

  void commint() {
    notifyListeners();
  }
}
