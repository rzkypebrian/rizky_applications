import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/listVehicle/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SieradView<SieradShipmentDetailHatcheryModel>
    extends View<SieradShipmentDetailHatcheryModel> {
  @override
  Widget statusRight(TmsVehicleModel<SieradShipmentDetailHatcheryModel> f) {
    String _pathEgg;
    if (f.vehicleStatusId == 0) {
      _pathEgg = "assets/sierad/redEgg.svg";
    } else if (f.vehicleStatusId == 1) {
      _pathEgg = "assets/sierad/greenEgg.svg";
    } else {
      _pathEgg = "assets/sierad/yellowEgg.svg";
    }
    return Container(
      width: 60,
      padding: EdgeInsets.only(left: 10),
      child: Center(
        // child: SvgPicture.asset(_pathEgg),
        child: SvgPicture.asset(_pathEgg),
      ),
    );
  }
}
