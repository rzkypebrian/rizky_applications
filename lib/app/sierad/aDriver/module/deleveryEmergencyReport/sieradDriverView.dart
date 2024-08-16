import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';

import 'package:enerren/module/deliveryEmergencyReport/main.dart';
import 'package:flutter/material.dart';
import 'sieradDriverPresenter.dart';

class SieradDriverView extends View with SieradDriverPresenter {
  TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment;
  String loadingAnimation;
  String loadingAssets;

  //sent data to presenter
  SieradDriverView({
    this.shipment,
    this.loadingAnimation,
    this.loadingAssets,
  }) {
    super.data = shipment;
  }

  @override
  Widget circularProgressIndicatorDecoration(
      {CircularProgressIndicatorController controller}) {
    return DecorationComponent.circularProgressDecoration(
      controller: loadingController,
      flareAnimation: loadingAnimation,
      flareAssets: loadingAssets,
    );
  }
}
