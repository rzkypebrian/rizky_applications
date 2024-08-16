import 'package:enerren/app/angkut/aDriver/module/emergencyReport/main.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:flutter/material.dart';

class AngkutView extends OnAppBarEmergencyButton with AngkutPresenter {
  final AngkutShipmentModel shipmentModel;
  final VoidCallback onSuccess;

  AngkutView({
    this.shipmentModel,
    this.onSuccess,
  }) {
    super.data = this.shipmentModel;
    super.onSuccess = this.onSuccess;
  }

  @override
  Widget circularProgressIndicatorDecoration(
      {CircularProgressIndicatorController controller}) {
    return DecorationComponent.circularLOadingIndicator(
      lightMode: false,
      controller: loadingController,
    );
  }
}
