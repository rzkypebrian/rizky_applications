import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/app/sierad/model/sieradDeliverStock.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:flutter/material.dart';

import 'package:enerren/module/deliveryPod/signatureOnlyView.dart';
import 'sieradDriverPresenter.dart';

class SieradDriverView extends SignatureOnlyView with SieradDriverPresernter {
  TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment;
  SieradDeliverStock stock;
  ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>> onSuccess;
  String loadingAnimation;
  String loadingAnimationAsset;

  SieradDriverView({
    @required this.shipment,
    this.onSuccess,
    this.stock,
    this.loadingAnimation,
    this.loadingAnimationAsset,
  }) {
    super.shipment = this.shipment;
    super.onSuccess = this.onSuccess;
    super.stock = this.stock;
  }

  @override
  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.model.loadingController,
      flareAnimation: loadingAnimation,
      flareAssets: loadingAnimationAsset,
    );
  }
}
