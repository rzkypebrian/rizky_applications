import 'package:enerren/model/tmsVehicleStatusSummary.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TmsVehicleStatusSummary vehicleStatusSummary = new TmsVehicleStatusSummary();

  void commit() {
    notifyListeners();
  }
}
