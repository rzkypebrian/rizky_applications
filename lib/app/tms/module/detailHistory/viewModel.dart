import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:flutter/material.dart';

class ViewModel<T> extends ChangeNotifier {
  TmsShipmentModel<T> shipment;

  void commit() {
    notifyListeners();
  }
}
