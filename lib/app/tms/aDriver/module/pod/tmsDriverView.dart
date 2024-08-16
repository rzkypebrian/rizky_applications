// import 'package:enerren/app/sierad/aDriver/module/pod/main.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/module/deliveryPod/signatureOnlyView.dart';
import 'package:flutter/material.dart';

// import 'package:enerren/module/deliveryPod/popUpSignaturePad.dart';
import 'tmsDriverPresenter.dart';

class TmsDriverView<T> extends SignatureOnlyView with TmsDriverPresernter<T> {
  TmsShipmentModel<T> shipment;
  ValueChanged<TmsShipmentModel<T>> onSuccess;

  TmsDriverView({
    @required this.shipment,
    this.onSuccess,
  }) {
    super.shipment = this.shipment;
    super.onSuccess = this.onSuccess;
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularProgressDecoration(
      controller: super.model.loadingController,
    );
  }
}
