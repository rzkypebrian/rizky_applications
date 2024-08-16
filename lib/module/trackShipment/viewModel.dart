import 'package:enerren/model/serchShipmentNumberHistory.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<SerchShipmentNumberHistory> receiptNumbers = [];

  void receiptIdDummy() {
    this.receiptNumbers = [];
  }

  void commit() {
    notifyListeners();
  }
}
