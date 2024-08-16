import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/deliveryPod/signatureOnlyView.dart';
// import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'finishPresenter.dart';
import 'package:flutter/material.dart';

class FinishView extends SignatureOnlyView with FinishPickup {
  final AngkutShipmentModel shipment;
  final ValueChanged<AngkutShipmentModel> onSuccessSubmit;
  final int idDestination;
  final bool isFinish;

  FinishView({
    @required this.shipment,
    this.onSuccessSubmit,
    this.idDestination,
    this.isFinish,
  }) {
    super.shipment = this.shipment;
    super.onFinishShipment = this.onSuccessSubmit;
    super.idDestination = this.idDestination;
    // ModeUtil.debugPrint(idDestination);
  }

  @override
  Widget buttonNavigationBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottonComponent.roundedButton(
            onPressed: () => super.submit(),
            text: System.data.resource.save,
            fontSize: System.data.fontUtil.m,
            colorBackground: System.data.colorUtil.primaryColor),
      ),
    );
  }

  Widget circularProgressIndicatorDecoration() {
    return DecorationComponent.circularLOadingIndicator(
      controller: super.model.loadingController,
    );
  }
}
