import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  AngkutShipmentModel shipment = new AngkutShipmentModel();

  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  int currentIndex = 0;
  bool showDetailInsurance = false;
  bool showShipCost = false;

  void personInCharge(int index) {
    if (index == 0) {
      shipment.payerName =
          shipment.tmsShipmentDestinationList.first.originContactPerson;
      shipment.payerPhoneNo =
          shipment.tmsShipmentDestinationList.first.originContactNumber;
    } else {
      shipment.payerName = shipment
          .tmsShipmentDestinationList[index - 1].destinationContactPerson;
      shipment.payerPhoneNo = shipment
          .tmsShipmentDestinationList[index - 1].destinationContactNumber;
    }
    currentIndex = index;
    commit();
  }

  void commit() {
    notifyListeners();
  }
}
