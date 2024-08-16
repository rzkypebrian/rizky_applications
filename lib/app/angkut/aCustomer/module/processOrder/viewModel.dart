import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  String animation;
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  AngkutShipmentModel shipmentModel;
  bool isFinish = false;
  String message;

  

  void commit() {
    notifyListeners();
  }
}


