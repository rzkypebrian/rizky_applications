import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  String urlDriverImmage;
  String driverName;
  String driverNik;
  String phoneNumber;
  String email;
  String address;
  DateTime birdDate;
  String vehicleType;
  double score;

  ViewModel({
    this.urlDriverImmage = "",
    this.driverName = "",
    this.driverNik = "",
    this.phoneNumber = "",
    this.email = "",
    this.address = "",
    this.birdDate,
    this.vehicleType = "",
    this.score = 0,
  });

  void copy(ViewModel model) {
    this.urlDriverImmage = model.urlDriverImmage;
    this.driverName = model.driverName;
    this.driverNik = model.driverNik;
    this.phoneNumber = model.phoneNumber;
    this.email = model.email;
    this.address = model.address;
    this.birdDate = model.birdDate;
    this.vehicleType = model.vehicleType;
    this.score = model.score;
    this.commit();
  }

  void commit() {
    notifyListeners();
  }
}
