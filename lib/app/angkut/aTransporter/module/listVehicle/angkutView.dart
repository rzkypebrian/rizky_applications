import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/module/listVehicle/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'angkutPresenter.dart';

class AngkutView<T> extends View<T> with AngkutPresenter<T> {
  @override
   PreferredSizeWidget appBar() {
    return BottonComponent.customAppBar1(
      title: System.data.resource.activity,
      context: context,
      actionText: "",
      titleColor: System.data.colorUtil.secondaryColor,
      backButtonColor: System.data.colorUtil.lightTextColor,
      actionTextStyle: System.data.textStyleUtil.mainLabel(),
      actionTextColor: System.data.colorUtil.lightTextColor,
      titleStyle: System.data.textStyleUtil.mainTitle(),
      backgroundColor: System.data.colorUtil.primaryColor,
    );
  }


  @override
  Widget vehicleItemView(TmsVehicleModel<T> f, VtsPositionModel positionModel) {
    Color _color = Colors.grey;
    if (f.vehicleStatusId == 0) {
      _color = System.data.colorUtil.redColor;
    } else if (f.vehicleStatusId == 1) {
      _color = System.data.colorUtil.greenColor;
    } else {
      _color = System.data.colorUtil.yellowColor;
    }
    print(f.vehicleTypeIconUrl);
    return DecorationComponent.vehicleItem(
      colorCircular: _color,
      vehicleType: f.vehicleTypeName,
      regNumber: f.vehicleRegNumber,
      vehicleNumber: f.vehicleNumber,
      regDate: f.vehicleRegDate,
      imageIconUrl: f.vehicleTypeIconUrl,
    );
  }

  @override
  Widget driverItemView(TmsVehicleModel<T> f, VtsPositionModel positionModel) {
    Color _color = Colors.grey;
    if (f.vehicleStatusId == 0) {
      _color = System.data.colorUtil.redColor;
    } else if (f.vehicleStatusId == 1) {
      _color = System.data.colorUtil.greenColor;
    } else {
      _color = System.data.colorUtil.yellowColor;
    }
    return DecorationComponent.driverItem(
      colorCircular: _color,
      driverName: f.driverName,
      driverRate: f.driverScore,
      driverSim: f.driverSimType,
      regDate: f.vehicleRegDate,
      noReg: f.vehicleRegNumber,
      imageUrl: f.driverImageUrl,
      vehicleNumber: f.vehicleNumber,
    );
  }

  @override
  Widget circularProgressIndicatorComponent() {
    return DecorationComponent.circularLOadingIndicator(
      controller: loadingController,
    );
  }
}
