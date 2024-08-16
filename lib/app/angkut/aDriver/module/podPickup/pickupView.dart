import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/deliveryPod/signatureOnlyView.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'pickupPresenter.dart';
import 'package:flutter/material.dart';

class PickUpView extends SignatureOnlyView with PickUpPresenter {
  final AngkutShipmentModel shipment;
  final ValueChanged<AngkutShipmentModel> onSuccessSubmit;

  PickUpView({
    @required this.shipment,
    this.onSuccessSubmit,
  }) {
    super.shipment = this.shipment;
    super.onFinishShipment = this.onSuccessSubmit;
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

  // @override
  // Widget receiverLabel({TextStyle textStyle}) {
  //   return Text(
  //     "${System.data.resource.senderName}",
  //     style: System.data.textStyleUtil.mainLabel(),
  //   );
  // }
}
