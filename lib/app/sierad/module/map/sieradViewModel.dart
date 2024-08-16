import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:flutter/material.dart';

class SieradViewModel extends ChangeNotifier {
  List<TmsVehicleModel> vehicles = [];
  List<TmsVehicleModel> filteredVehicle = [];
  TmsVehicleModel selectedVehicle;
  InputComponentTextEditingController searchController =
      new InputComponentTextEditingController();
  PageController pageController;

  int currentPage;

  InputComponentTextEditingController fromDateController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController toDateController =
      new InputComponentTextEditingController();
  DateTime selectedFromDate;
  DateTime selectedToDate;

  void commit() {
    notifyListeners();
  }
}
