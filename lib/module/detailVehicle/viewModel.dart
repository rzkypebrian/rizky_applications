import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  TmsVehicleModel vehicleModel;
  VtsPositionModel vtsPositionModel;
  // String vehicleName;
  // String vehicleType;
  // String vehicleNumber;
  // String vehicleTypeImageUrl;
  // String sensor;
  // String driverName;
  // String status;

  ViewModel({
    this.vehicleModel,
    this.vtsPositionModel,
    // this.vehicleName,
    // this.vehicleType,
    // this.vehicleNumber,
    // this.vehicleTypeImageUrl,
    // this.sensor,
    // this.driverName,
    // this.status,
  });

  void copy(ViewModel model) {
    this.vehicleModel = model.vehicleModel;
    this.vtsPositionModel = model.vtsPositionModel;
    // this.vehicleName = model.vehicleName;
    // this.vehicleType = model.vehicleType;
    // this.vehicleNumber = model.vehicleNumber;
    // this.vehicleTypeImageUrl = model.vehicleTypeImageUrl;
    // this.sensor = model.sensor;
    // this.driverName = model.driverName;
    // this.status = model.status;
  }

  void commit() {
    notifyListeners();
  }
}
