import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  List<ShipmentItemDescriptionViewModel> shipmentItemDescriptions =
      <ShipmentItemDescriptionViewModel>[];

  ViewModel({
    this.shipmentItemDescriptions,
  }) {
    this.shipmentItemDescriptions = this.shipmentItemDescriptions ?? [];
  }

  void commit() {
    notifyListeners();
  }
}
