import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  double scoreValue;
  double scoreMax;
  int canceledJob;
  int overSpeed;
  double averageSpeed;
  int finishedJob;

  void commit() {
    notifyListeners();
  }
}
