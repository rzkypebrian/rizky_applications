import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment;

  void commit() {
    notifyListeners();
  }
}
