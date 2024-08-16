import 'package:enerren/model/tmsShipmentHistory.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<TmsShipmentHistory> data;
  String shipmentNumber;

  ViewModel({
    this.data,
    this.shipmentNumber,
  });

  void commit() {
    notifyListeners();
  }
}
