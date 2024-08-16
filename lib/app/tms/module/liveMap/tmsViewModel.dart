import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:flutter/material.dart';

class TmsViewModel<T> extends ChangeNotifier {
  PageController pageController;
  int currentPage = 0;
  List<TmsShipmentModel<T>> shipment;
  TmsShipmentModel<T> selectedShipment;

  String driverName;
  int rating;
  String customerPhoneNumber;
  String driverPhoneNumber;
  String email;
  DateTime birdDate;
  String address;
  String vehicleName;
  String vehicleImageUrl;
  String vehicleType;
  String vehicleNumber;
  int temperature;
  String backdoorSensorCode;
  bool backdoor;
  String fanSensorCode;
  bool fan;
  String driverImageUrl;
  String originAddress;
  String desinationAddress;
  double originLat;
  double originLon;
  double destinationLat;
  double destinationLon;
  String shipmentType;
  String nik;

  TmsViewModel({
    this.driverName,
    this.rating,
    this.customerPhoneNumber,
    this.driverPhoneNumber,
    this.email,
    this.birdDate,
    this.address,
    this.vehicleName,
    this.vehicleImageUrl,
    this.vehicleType,
    this.vehicleNumber,
    this.temperature,
    this.backdoorSensorCode,
    this.backdoor,
    this.fanSensorCode,
    this.fan,
    this.driverImageUrl,
    this.originAddress,
    this.desinationAddress,
    this.destinationLat,
    this.destinationLon,
    this.originLat,
    this.originLon,
    this.shipmentType,
    this.nik,
    this.shipment,
    this.selectedShipment,
  }) {
    //copy to single
  }

  void commit() {
    notifyListeners();
  }
}
