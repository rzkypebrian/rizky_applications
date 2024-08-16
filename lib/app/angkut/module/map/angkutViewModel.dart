import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:flutter/material.dart';

class AngkutViewModel extends ChangeNotifier {
  List<TmsVehicleModel<AngkutShipmentModel>> vehicles = [];
  TmsVehicleModel selectedVehicle;

  PageController pageController;

  InputComponentTextEditingController fromDateController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController toDateController =
      new InputComponentTextEditingController();
  DateTime selectedFromDate;
  DateTime selectedToDate;

  int currentPage;

  void commit() {
    notifyListeners();
  }
}
