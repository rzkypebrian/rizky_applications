import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class HomeViewer extends ChangeNotifier {
  AngkutShipmentModel angkutShipmentModel = AngkutShipmentModel();

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  void commit() {
    notifyListeners();
  }
}
