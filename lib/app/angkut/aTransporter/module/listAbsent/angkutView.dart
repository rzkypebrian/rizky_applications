import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/tmsVehicleCheckDocument.dart';
import 'package:enerren/module/listAbsent/view.dart';
import 'angkutPresenter.dart';
import 'package:flutter/material.dart';

class AngkutView extends View with AngkutPresenter {
  @override
  Widget content(TmsVehicleCheckDocument data) {
    return GestureDetector(
      onTap: () => super.onTapAbsent(data),
      child: DecorationComponent.driverItem(
        withStatusColor: false,
        driverName: data.driverName,
        driverRate: data.driverRating,
        driverSim: data.driverSimType,
        regDate: data.checkTime,
        noReg: data.driverRegNumber,
        imageUrl: data.driverImageUrl,
        vehicleNumber: data.vehicleNumber,
      ),
    );
  }
}
