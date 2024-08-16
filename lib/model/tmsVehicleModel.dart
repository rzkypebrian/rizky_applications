import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsVehicleModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsVehicleModel<T> {
  int vehicleId;
  int vtsVehicleId;
  String vehicleName;
  String vehicleNumber;
  String vehicleRegNumber;
  DateTime vehicleRegDate;
  int vehicleStatusId; //0 rest, 1 standby, 2 order
  String vehicleStatusName;
  String vehicleTypeCode;
  String vehicleTypeName;
  String vehicleTypeIconUrl;
  String vehicleTypeIconUrlTop;
  int vehicleTypeIconTopSize;
  String vehicleSensor;
  String vehicleBackDoorSensor;
  String vehicleFanSensor;
  String vehicleTemperatureSensor;
  bool vehicleBackDoorSensorValue;
  bool vehicleFanSensorValue;
  String vehicleTemperatureSensorValue;
  String transporterCode;
  String transporterName;
  int driverId;
  String driverNik;
  String driverName;
  String driverImageUrl;
  DateTime driverBirthDate;
  String driverEmail;
  String driverSimType;
  double driverScore;
  String driverAddress;
  String driverPhoneNumber;
  List<T> shipmentHeaderData;
  bool isSuitable;

  TmsVehicleModel({
    this.vehicleId,
    this.vtsVehicleId,
    this.vehicleName,
    this.vehicleNumber,
    this.vehicleRegNumber,
    this.vehicleRegDate,
    this.vehicleStatusId,
    this.vehicleStatusName,
    this.vehicleTypeCode,
    this.vehicleTypeName,
    this.vehicleTypeIconUrl,
    this.vehicleTypeIconUrlTop,
    this.vehicleTypeIconTopSize,
    this.vehicleSensor,
    this.vehicleBackDoorSensor,
    this.vehicleFanSensor,
    this.vehicleTemperatureSensor,
    this.vehicleBackDoorSensorValue,
    this.vehicleFanSensorValue,
    this.vehicleTemperatureSensorValue,
    this.transporterCode,
    this.transporterName,
    this.driverId,
    this.driverNik,
    this.driverName,
    this.driverImageUrl,
    this.driverBirthDate,
    this.driverEmail,
    this.driverSimType,
    this.driverScore,
    this.driverAddress,
    this.driverPhoneNumber,
    this.shipmentHeaderData,
    this.isSuitable = false,
  });

  static TmsVehicleModel<T> fromJson<T>(Map<String, dynamic> json,
          {ChildReader<T> childReader}) =>
      _$TmsVehicleModelFromJson<T>(json, childReader: childReader);

  Map<String, dynamic> toJson() => _$TmsVehicleModelToJson(this);

  static Future<List<TmsVehicleModel<T>>> getAll<T>({
    String token,
    int vehicleStatus,
    ChildReader<T> childReader,
  }) {
    return NetworkUtil()
        .get(
      System.data.apiEndPointUtil
          .getTmsVehicleList(vehicleStatus: vehicleStatus),
      headers: {
        "lang": System.data.resource.lang,
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      useTimeOutLimt: false,
    )
        .then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => TmsVehicleModel.fromJson<T>(f, childReader: childReader))
          .toList();
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
      throw onError;
    });
  }
}
