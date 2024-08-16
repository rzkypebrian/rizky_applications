import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsVehicleCheckDocument.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsVehicleCheckDocument {
  String checkFileGuid;
  int shipmentRef;
  int driverId;
  String driverName;
  String driverRegNumber;
  String driverSimType;
  double driverRating;
  String driverImageUrl;
  int vehicleId;
  String vehicleName;
  String vehicleNumber;
  int vehicleTypeId;
  String vehicleTypeName;
  DateTime checkTime;
  String checkNote;
  bool fuelLevel;
  bool machineTemperature;
  bool oilLevel;
  bool accuStatus;
  List<String> selfiePhoto;

  TmsVehicleCheckDocument({
    this.checkFileGuid,
    this.shipmentRef,
    this.driverId,
    this.driverName,
    this.driverRegNumber,
    this.driverSimType,
    this.driverRating,
    this.driverImageUrl,
    this.vehicleId,
    this.vehicleName,
    this.vehicleNumber,
    this.vehicleTypeId,
    this.vehicleTypeName,
    this.checkTime,
    this.checkNote,
    this.fuelLevel,
    this.machineTemperature,
    this.oilLevel,
    this.accuStatus,
    this.selfiePhoto,
  });

  factory TmsVehicleCheckDocument.fromJson(Map<String, dynamic> json) =>
      _$TmsVehicleCheckDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$TmsVehicleCheckDocumentToJson(this);

  static Future<TmsVehicleCheckDocument> add({
    TmsVehicleCheckDocument param,
    String token,
  }) {
    return NetworkUtil()
        .post(
      System.data.apiEndPointUtil.addVehicleCheckDaily(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: param.toJson(),
      encoding: Encoding.getByName("apliaction/json"),
    )
        .then((onValue) {
      return TmsVehicleCheckDocument.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<TmsVehicleCheckDocument>> getAll({
    String token,
    DateTime checkTime,
    bool isLowerThanId,
    String searchKey,
  }) {
    return NetworkUtil().post(
        System.data.apiEndPointUtil.getVehicleCheckDaily(
          checkTime: checkTime,
          isLowerThanId: isLowerThanId,
          searchKey: searchKey,
        ),
        headers: {
          "lang": System.data.resource.lang,
          HttpHeaders.authorizationHeader: "bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => TmsVehicleCheckDocument.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
