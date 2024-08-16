import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:flutter/material.dart';

class ViewModel<T> extends ChangeNotifier {
  int selectedTab = 0;
  int selectetDriver = 0;
  int selectedVehicle = 0;
  List<TmsVehicleModel<T>> vehicles = [];
  List<VtsPositionModel> positions = [];
  List<TmsVehicleModel<T>> suitableVehicle = [];

  void commit() {
    notifyListeners();
  }
}
