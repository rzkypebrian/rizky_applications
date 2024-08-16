import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  int movingVehicles = 0;
  int inPoolVehicles = 0;
  int maintenanceVehicles = 0;
  int rankTotal;

  int get totalVehicles {
    try {
      return movingVehicles + inPoolVehicles + maintenanceVehicles;
    } catch (e) {
      return 0;
    }
  }

  ViewModel({
    this.movingVehicles,
    this.inPoolVehicles,
    this.maintenanceVehicles,
    this.rankTotal,
  });

  factory ViewModel.dummy() {
    return ViewModel(
      inPoolVehicles: 3,
      movingVehicles: 5,
      maintenanceVehicles: 7,
      rankTotal: 50,
    );
  }

  void commit() {
    notifyListeners();
  }
}
