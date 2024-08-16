import 'package:enerren/component/vehicleInfoDecoration.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/module/detailVehicle/view.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'tmsPresenter.dart';

class TmsView extends View with TmsPresenter {
  Widget detailSensor() { 
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${System.data.resource.sensor}",
            style: System.data.textStyleUtil.mainLabel(
              color: System.data.colorUtil.inputTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.only(right: 20, left: 15),
            child: VehicleInfoDecoration.userDefinedSensorView(
              vtsPositionModel: model.vtsPositionModel,
              showFanSensor: true,
              fanSensor: VtsPositionModel.readSensor(
                  model.vehicleModel.vehicleFanSensor,
                  model.vtsPositionModel) as bool,
              showBackdoorSensor: true,
              backDoorSensor: VtsPositionModel.readSensor(
                  model.vehicleModel.vehicleBackDoorSensor,
                  model.vtsPositionModel) as bool,
              showTempSensor: true,
              dividerColor: Colors.transparent,
              spaceHeight: 5,
            ),
          )
        ],
      ),
    );
  }
}
