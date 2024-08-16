import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';

import 'package:enerren/module/deliveryEmergencyReport/main.dart';
import 'package:flutter/material.dart';
import 'driverPresenter.dart';

class DriverView<T> extends View with DriverPresenter {
  TmsShipmentModel<T> shipment;
  VoidCallback onSuccess;

  //sent data to presenter
  DriverView({
    this.shipment,
    this.onSuccess,
  }) {
    super.data = shipment;
    super.onSuccess = onSuccess;
  }

  @override
  Widget circularProgressIndicatorDecoration(
      {CircularProgressIndicatorController controller}) {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
    );
  }
}
