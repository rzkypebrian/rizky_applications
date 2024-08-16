import 'package:enerren/model/VtsFleetModel.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<VtsPositionModel> vehicles = [];
  List<VtsPositionModel> filteredVehicles = [];
  List<VtsFleetModel> fleets = [];
  VtsFleetModel selectedFleet;

  void commit() {
    notifyListeners();
  }
  
}
