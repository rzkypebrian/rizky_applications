import 'dart:convert';
import 'dart:io';

import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsDeliveryEmergencyModel.g.dart';

@JsonSerializable()
class TmsDeliveryEmergencyModel {
  String emergencyFileGuid;
  int destinationId;
  int vehicleId;
  String vehicleNumber;
  int driverId;
  String driverName;
  String driverImageUrl;
  double driverRating;
  int memberId;
  DateTime emergencyTime;
  String emergencyNote;
  String emergencyFile;
  int emergencyStatus;
  double emergencyLat;
  double emergencyLon;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  DateTime modifiedDate;
  int lastShipmentStatus;
  DriverModel driverData;

  TmsDeliveryEmergencyModel({
    this.emergencyFileGuid,
    this.destinationId,
    this.vehicleId,
    this.vehicleNumber,
    this.driverId,
    this.driverName,
    this.driverImageUrl,
    this.driverRating,
    this.memberId,
    this.emergencyTime,
    this.emergencyNote,
    this.emergencyFile,
    this.emergencyStatus,
    this.emergencyLat,
    this.emergencyLon,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.modifiedDate,
    this.lastShipmentStatus,
    this.driverData,
  });

  factory TmsDeliveryEmergencyModel.fromJson(Map<String, dynamic> data) =>
      _$TmsDeliveryEmergencyModelFromJson(data);

  Map<String, dynamic> toJson() => _$TmsDeliveryEmergencyModelToJson(this);

  static Future<List<TmsDeliveryEmergencyModel>> get({
    @required String token,
    int shipmentId,
    String emergencyId,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
        System.data.apiEndPointUtil.tmsGetEmergency(
          shipmentId: shipmentId,
          emergencyId: emergencyId,
        ),
        headers: {
          "lang": "${System.data.resource.lang}",
          HttpHeaders.authorizationHeader: "bearer $token",
        }).then((onValue) {
      return (json.decode(onValue.toString()) as List)
          .map((e) => new TmsDeliveryEmergencyModel.fromJson(e))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<String> add({
    @required String token,
    TmsDeliveryEmergencyInputModel param,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      System.data.apiEndPointUtil.tmsAddEmergency(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: param.toJson(),
      encoding: Encoding.getByName("application/json"),
    )
        .then((res) {
      return res.toString();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> rejectEmergency({
    @required String token,
    int shipmentId,
    String reasonDesc,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      System.data.apiEndPointUtil.rejectEmergencyShipment(
        shipmentId: shipmentId,
        reasonDesc: reasonDesc,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      encoding: Encoding.getByName("application/json"),
    )
        .then((res) {
      return json.decode(res) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }

  static List<TmsDeliveryEmergencyModel> dummy() {
    List<Map<String, dynamic>> data = [
      {
        "emergencyFileGuid": "95437e4c-09f5-4f65-9bfd-b164d03d1503",
        "destinationId": 6,
        "vehicleNumber": "B9568UIN",
        "driverId": 1,
        "driverName": "JOKO PUTRO",
        "memberId": 0,
        "emergencyTime": "2019-12-26T10:11:24.387",
        "emergencyNote": "test aja",
        "emergencyFile":
            "http://dev.enerren.com/InovaTMSAPI/StaticFiles/emergency/e57fcd1e-c24e-4c20-b5cc-8cded3eee0f8.svg+xml",
        "emergencyStatus": 0,
        "insertedBy": null,
        "insertedDate": "2019-12-31T10:52:46.317614Z",
        "modifiedBy": null,
        "modifiedDate": null
      },
      {
        "emergencyFileGuid": "d92a28b7-20e1-4177-b6c7-2892268fcbbe",
        "destinationId": 5,
        "vehicleNumber": "B 4567 BCC",
        "driverId": 1,
        "driverName": "JOKO PUTRO",
        "memberId": 0,
        "emergencyTime": "2019-12-26T05:00:26.913",
        "emergencyNote": "Ban Bocor 2",
        "emergencyFile":
            "http://dev.enerren.com/InovaTMSAPI/StaticFiles/emergency/45f8d777-3c64-4441-b94d-9b9c356933ea.jpeg",
        "emergencyStatus": 1,
        "insertedBy": null,
        "insertedDate": "2019-12-31T10:52:46.317614Z",
        "modifiedBy": null,
        "modifiedDate": null
      },
      {
        "emergencyFileGuid": "f7ee5bd1-5686-4a18-873c-8b9b2eb67e0f",
        "destinationId": 3,
        "vehicleNumber": "B 4567 BVC",
        "driverId": 1,
        "driverName": "JOKO PUTRO",
        "memberId": 0,
        "emergencyTime": "2019-12-26T05:00:26.913",
        "emergencyNote": "Ban Bocor",
        "emergencyFile":
            "http://dev.enerren.com/InovaTMSAPI/StaticFiles/emergency/1449dbf0-c2e9-4943-ab92-a15b484ef848.jpeg",
        "emergencyStatus": 1,
        "insertedBy": null,
        "insertedDate": "2019-12-31T10:52:46.317614Z",
        "modifiedBy": null,
        "modifiedDate": null
      },
      {
        "emergencyFileGuid": "f7f9e4a4-e604-4cf3-9aea-5955c51df4bc",
        "destinationId": 4,
        "vehicleNumber": "B6666VC",
        "driverId": 1,
        "driverName": "JOKO PUTRO",
        "memberId": 0,
        "emergencyTime": "2019-12-26T10:13:15.03",
        "emergencyNote": "nxkgndfkg",
        "emergencyFile":
            "http://dev.enerren.com/InovaTMSAPI/StaticFiles/emergency/5c589b03-4b6c-4ee1-bc26-8fb0fc9a7e41.jpeg",
        "emergencyStatus": 1,
        "insertedBy": null,
        "insertedDate": "2019-12-31T10:52:46.317614Z",
        "modifiedBy": null,
        "modifiedDate": null
      }
    ];
    return data.map((f) => TmsDeliveryEmergencyModel.fromJson(f)).toList();
  }
}

@JsonSerializable()
class TmsDeliveryEmergencyInputModel {
  int destinationId;
  String vehicleNumber;
  int vehicleId;
  int driverId;
  int memberId;
  DateTime emergencyTime;
  String emergencyNote;
  String emergencyFile;
  int emergencyStatus;
  double emergencyLat;
  double emergencyLon;
  String insertedBy;

  TmsDeliveryEmergencyInputModel({
    this.destinationId,
    this.vehicleNumber,
    this.vehicleId,
    this.driverId,
    this.memberId,
    this.emergencyTime,
    this.emergencyNote,
    this.emergencyFile,
    this.emergencyStatus,
    this.emergencyLat,
    this.emergencyLon,
    this.insertedBy,
  });

  factory TmsDeliveryEmergencyInputModel.fromJson(data) =>
      _$TmsDeliveryEmergencyInputModelFromJson(data);

  Map<String, dynamic> toJson() => _$TmsDeliveryEmergencyInputModelToJson(this);
}
