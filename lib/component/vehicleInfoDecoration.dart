import 'package:enerren/component/externalLinkComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class VehicleInfoDecoration {
  static Widget popupMapVehicleInfo({
    VtsPositionModel vtsPositionModel,
    String vehicleName,
    String vehicleType,
    String vehicleNumber,
    double temperature,
    String vehicleImageUrl,
    Widget topLeftWidget,
    double lat,
    double lon,
    String phoneNumber,
    ValueChanged2Param<double, double> onTapGotoMap,
    bool backDoorSensor,
    bool fanSensor,
    bool showTempSensor = true,
    bool showBackdoorSensor = true,
    bool showFanSensor = true,
    bool autoGenerateSensor = false,
    bool showMapLink = true,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: topLeftWidget,
              ),
              ExternalLinkComponent.mapPhoneWA(
                lat: lat,
                lon: lon,
                phoneNumber: phoneNumber,
                onTapMap: onTapGotoMap,
                showMapLink: showMapLink,
              )
            ],
          )),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: System.data.colorUtil.primaryColor),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: SvgPicture.network(
                          "$vehicleImageUrl",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "$vehicleName",
                      style: System.data.textStyleUtil.mainLabel(
                          color: System.data.colorUtil.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    color: System.data.colorUtil.blackColor,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${System.data.resource.vehicleType}",
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${System.data.resource.vehicleNumber}",
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "$vehicleType",
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.blackColor,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "$vehicleNumber",
                                  style: System.data.textStyleUtil.mainLabel(
                                    color: System.data.colorUtil.blackColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              showBackdoorSensor == false &&
                                      showTempSensor == false &&
                                      showFanSensor == false &&
                                      autoGenerateSensor == false &&
                                      temperature == null &&
                                      vtsPositionModel?.temp1 == null
                                  ? Container(
                                      height: 0,
                                      width: 0,
                                    )
                                  : Container(
                                      child: Text(
                                        "${System.data.resource.sensor}",
                                        style:
                                            System.data.textStyleUtil.mainLabel(
                                          color: System
                                              .data.colorUtil.primaryColor,
                                        ),
                                      ),
                                    ),
                              Container(
                                // color: Colors.blue,
                                padding: EdgeInsets.only(left: 20),
                                child: autoGenerateSensor == false
                                    ? userDefinedSensorView(
                                        showFanSensor: showBackdoorSensor,
                                        temperature: temperature,
                                        showBackdoorSensor: showBackdoorSensor,
                                        backDoorSensor: backDoorSensor,
                                        showTempSensor: showFanSensor,
                                        fanSensor: fanSensor,
                                      )
                                    : autoGenerateSensorView(
                                        vtsPositionModel: vtsPositionModel,
                                        temperature: temperature,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget tempSensorView({
    double temperature,
    double temperatureAlt,
    Color dividerColor,
    double spaceHeight,
  }) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.temperature}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text("${temperature ?? temperatureAlt ?? "-"}"),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      child: FlareActor(
                        "assets/flares/temperature_warm.flr",
                        animation: "play",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: spaceHeight,
          color: dividerColor ?? System.data.colorUtil.blackColor,
        ),
      ],
    );
  }

  static Widget backdoorSensorView(
    bool backDoorSensor, {
    Color dividerColor,
    double spaceHeight,
  }) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.backDoor}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                          "${backDoorSensor == false ? System.data.resource.closed : backDoorSensor == true ? System.data.resource.open : "-"}"),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      child: FlareActor(
                        "assets/flares/backdoor.flr",
                        animation:
                            "${backDoorSensor == false ? "close" : backDoorSensor == true ? "open" : "colse"}",
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: spaceHeight,
          color: dividerColor ?? System.data.colorUtil.blackColor,
        ),
      ],
    );
  }

  static Widget fanSensorView(
    bool fanSensor, {
    Color dividerColor,
    double spaceHeight,
  }) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${System.data.resource.fan}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                          "${fanSensor == false ? System.data.resource.on : fanSensor == true ? System.data.resource.off : "-"}"),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      child: FlareActor(
                        "assets/flares/fan.flr",
                        animation:
                            "${fanSensor == false ? "play" : fanSensor == true ? "off" : "-"}",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: spaceHeight,
          color: dividerColor ?? System.data.colorUtil.blackColor,
        )
      ],
    );
  }

  static Widget userDefinedSensorView({
    VtsPositionModel vtsPositionModel,
    bool showTempSensor,
    double temperature,
    bool showBackdoorSensor,
    bool backDoorSensor,
    bool showFanSensor,
    bool fanSensor,
    Color dividerColor,
    double spaceHeight,
  }) {
    return Column(
      children: <Widget>[
        //temp sensor
        showTempSensor
            ? tempSensorView(
                temperature: temperature,
                temperatureAlt: vtsPositionModel?.temp1,
                dividerColor: dividerColor,
                spaceHeight: spaceHeight,
              )
            : Container(
                height: 0,
                width: 0,
              ),
        //sensor backdoor
        showBackdoorSensor
            ? backdoorSensorView(
                backDoorSensor,
                dividerColor: dividerColor,
                spaceHeight: spaceHeight,
              )
            : Container(
                width: 0,
                height: 0,
              ),
        //sensor fan
        showFanSensor
            ? fanSensorView(
                fanSensor,
                dividerColor: dividerColor,
                spaceHeight: spaceHeight,
              )
            : Container(
                width: 0,
                height: 0,
              ),
      ],
    );
  }

  static Widget autoGenerateSensorView({
    VtsPositionModel vtsPositionModel,
    double temperature,
    Color dividerColor,
    EdgeInsetsGeometry margin,
    double space,
  }) {
    return Column(
      children: <Widget>[
        temperature != null || vtsPositionModel?.temp1 != null
            ? sensorItem(
                dividerColor: dividerColor,
                margin: margin,
                space: space,
                sensorName: System.data.resource.temperature,
                sensorValue:
                    "${temperature?.toString() ?? vtsPositionModel?.temp1?.toString() ?? "-"} ${System.data.resource.celciusDegree}",
              )
            : Container(
                height: 0,
                width: 0,
              ),
        vtsPositionModel.status1Label != null
            ? sensorItem(
                dividerColor: dividerColor,
                margin: margin,
                space: space,
                sensorName: vtsPositionModel.status1Label.split(" ")[0],
                sensorValue: vtsPositionModel.status1Label,
              )
            : Container(
                height: 0,
                width: 0,
              ),
        vtsPositionModel.status2Label != null
            ? sensorItem(
                dividerColor: dividerColor,
                margin: margin,
                space: space,
                sensorName: vtsPositionModel.status2Label.split(" ")[0],
                sensorValue: vtsPositionModel.status2Label,
              )
            : Container(
                height: 0,
                width: 0,
              ),
        vtsPositionModel.status3Label != null
            ? sensorItem(
                dividerColor: dividerColor,
                margin: margin,
                space: space,
                sensorName: vtsPositionModel.status3Label.split(" ")[0],
                sensorValue: vtsPositionModel.status3Label,
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ],
    );
  }

  static Widget sensorItem({
    String sensorName,
    String sensorValue,
    Color dividerColor,
    EdgeInsetsGeometry margin,
    double space,
  }) {
    return Column(
      children: <Widget>[
        Container(
          margin: margin ?? EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${toBeginningOfSentenceCase(sensorName.toLowerCase())}",
                  style: System.data.textStyleUtil.mainLabel(),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: margin ?? EdgeInsets.only(right: 5),
                      child: Text(
                          "${toBeginningOfSentenceCase(sensorValue.toLowerCase())}"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: space,
          color: dividerColor ?? System.data.colorUtil.blackColor,
        )
      ],
    );
  }
}
