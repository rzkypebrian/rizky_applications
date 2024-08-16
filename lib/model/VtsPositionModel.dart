import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:enerren/util/StringExtention.dart';
part 'VtsPositionModel.g.dart';

@JsonSerializable(explicitToJson: true)
class VtsPositionModel {
  @JsonKey(name: "position_id")
  int positionId;

  @JsonKey(name: "vehicle_id")
  int vehicleId;

  @JsonKey(name: "vehicle_name")
  String vehicleName;

  @JsonKey(name: "vehicle_number")
  String vehicleNumber;

  @JsonKey(name: "vehicle_type")
  String vehicleType;

  @JsonKey(name: "gsm_number")
  String gsmNumber;

  @JsonKey(name: "gps_valid")
  bool gpsValid;

  @JsonKey(name: "date_time")
  DateTime dateTime;

  @JsonKey(name: "x")
  double x;

  @JsonKey(name: "y")
  double y;

  @JsonKey(name: "speed")
  double speed;

  @JsonKey(name: "course")
  double course;

  @JsonKey(name: "trip_odometer")
  double tripOdometer;

  @JsonKey(name: "odometer")
  double odometer;

  @JsonKey(name: "engine_hour_meter")
  double engineHourMeter;

  @JsonKey(name: "engine")
  int engine;

  @JsonKey(name: "emergency")
  bool emergency;

  @JsonKey(name: "status_1")
  bool status1;

  @JsonKey(name: "status_1_label")
  String status1Label;

  @JsonKey(name: "status_2")
  bool status2;

  @JsonKey(name: "status_2_label")
  String status2Label;

  @JsonKey(name: "status_3")
  bool status3;

  @JsonKey(name: "status_3_label")
  String status3Label;

  @JsonKey(name: "fuel_level")
  int fuelLevel;

  @JsonKey(name: "street_name")
  String streetName;

  @JsonKey(name: "kecamatan")
  String kecamatan;

  @JsonKey(name: "kabupaten")
  String kabupaten;

  @JsonKey(name: "geofence_name")
  String geofenceName;

  @JsonKey(name: "driver_name")
  String driverName;

  @JsonKey(name: "overspeed")
  bool overspeed;

  @JsonKey(name: "idling")
  bool idling;

  @JsonKey(name: "main_power")
  bool mainPower;

  @JsonKey(name: "fuel_level_liter")
  double fuelLevelLiter;

  @JsonKey(name: "temp_1")
  double temp1;

  @JsonKey(name: "image_icon_url")
  String imageIconUrl;

  int iconSize;

  double get lat => this.y * 1E-7;
  double get lon => this.x * 1E-7;

  VtsPositionModel({
    this.positionId,
    this.vehicleId,
    this.vehicleName,
    this.vehicleNumber,
    this.vehicleType,
    this.gsmNumber,
    this.gpsValid,
    this.dateTime,
    this.x,
    this.y,
    this.speed,
    this.course,
    this.tripOdometer,
    this.odometer,
    this.engineHourMeter,
    this.engine,
    this.emergency,
    this.status1,
    this.status1Label,
    this.status2,
    this.status2Label,
    this.status3,
    this.status3Label,
    this.fuelLevel,
    this.streetName,
    this.kecamatan,
    this.kabupaten,
    this.geofenceName,
    this.driverName,
    this.overspeed,
    this.idling,
    this.mainPower,
    this.fuelLevelLiter,
    this.temp1,
    this.imageIconUrl,
    this.iconSize,
  });

  factory VtsPositionModel.fromJson(Map<String, dynamic> json) =>
      _$VtsPositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$VtsPositionModelToJson(this);

  static Future<List<VtsPositionModel>> get({
    @required int vehicleId,
    @required DateTime startDate,
    @required DateTime toDate,
    bool showLastPotionOnEmpty = false,
  }) {
    return NetworkUtil()
        .get(System.data.apiEndPointUtil.getVtsPositionHistory(
      vehicleId: vehicleId,
      fromDate: startDate,
      toDate: toDate,
    ))
        .then((onValue) async {
      if ((json.decode(onValue) as List).length > 0) {
        return (json.decode(onValue) as List)
            .map((f) => VtsPositionModel.fromJson(f))
            .toList();
      } else {
        if (showLastPotionOnEmpty == true) {
          return getVehiclePositionAsList(vehicleId: vehicleId).then((value) {
            return value;
          }).catchError((onError) {
            throw onError;
          });
        } else {
          return <VtsPositionModel>[];
        }
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<VtsPositionModel>> getAllPotition({
    @required int userId,
    @required String token,
  }) {
    return NetworkUtil()
        .get(
      System.data.apiEndPointUtil.getVtsAllPosition(
        userId: userId,
        token: token,
      ),
      useTimeOutLimt: false,
    )
        .then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => VtsPositionModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<VtsPositionModel> getVehiclePosition({
    @required int vehicleId,
  }) {
    return NetworkUtil().get(
        System.data.apiEndPointUtil.getVtsVehiclePosition(
          vehicleId: vehicleId,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((onValue) {
      return VtsPositionModel.fromJson((json.decode(onValue)));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<VtsPositionModel>> getVehiclePositionAsList({
    @required int vehicleId,
  }) {
    return NetworkUtil().get(
        System.data.apiEndPointUtil.getVtsVehiclePosition(
          vehicleId: vehicleId,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((onValue) {
      return <VtsPositionModel>[
        VtsPositionModel.fromJson((json.decode(onValue)))
      ];
    }).catchError((onError) {
      throw onError;
    });
  }

  static dynamic readSensor(String sensorName, VtsPositionModel position) {
    switch (sensorName) {
      case "input_1":
        // return position.status1;
        return converSensorLabelToBool(position.status1Label);
        break;
      case "input_2":
        // return position.status2;
        return converSensorLabelToBool(position.status2Label);
        break;
      case "input_3":
        // return position.status3;
        return converSensorLabelToBool(position.status3Label);
        break;
      case "temp_1":
        return position.temp1;
        break;
      default:
        return position.toJson()[sensorName];
        break;
    }
  }

  static bool converSensorLabelToBool(String label) {
    if (label.isNullOrEmpty()) {
      return null;
    } else if (label.toLowerCase().contains("off") ||
        label.toLowerCase().contains("open")) {
      return true;
    } else {
      return false;
    }
  }

  static int getTemperatureLevel(
    int temp, {
    int middleLine = 40,
    int topLine = 80,
  }) {
    if (temp > topLine) {
      return 3;
    } else if (temp > middleLine) {
      return 2;
    } else {
      return 1;
    }
  }
}
