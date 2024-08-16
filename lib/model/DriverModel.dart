import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'DriverModel.g.dart';

//run flutter clean
//run in terminal : flutter pub get
//run in terminal : flutter pub run build_runner build => for generate json map data
@JsonSerializable(explicitToJson: true)
class DriverModel {
  int driverId;
  String driverNik;
  String driverName;
  String driverCode;
  int memberId;
  String username;
  String email;
  String password;
  String confirmPassword;
  String simNumber;
  String gsmNumber;
  String phoneNumber;
  bool phoneNumberConfirmed;
  int status; // 0 siaga 1 order 2 res
  DateTime lastLoginTime;
  String udid;
  String registrationCode;
  String pinHash;
  String insertedBy;
  DateTime insertedDate;
  String modifiedBy;
  DateTime modifiedDate;
  String token;
  DateTime tokenExpiredTime;
  String urlProfileImage;
  double score;
  String simType;
  bool isReadyToWork;
  String adminPhoneNumber;
  String adminWhatsAppNumber;
  String transporterPhoneNumber;
  String transporterWhatsAppNumber;
  int vehicleIdVts;

  DriverModel({
    this.driverNik,
    this.driverId,
    this.driverName,
    this.driverCode,
    this.memberId,
    this.username,
    this.email,
    this.password,
    this.confirmPassword,
    this.simNumber,
    this.gsmNumber,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.status,
    this.lastLoginTime,
    this.udid,
    this.registrationCode,
    this.pinHash,
    this.insertedBy,
    this.insertedDate,
    this.modifiedBy,
    this.modifiedDate,
    this.token,
    this.tokenExpiredTime,
    this.urlProfileImage,
    this.score,
    this.simType,
    this.isReadyToWork,
    this.adminPhoneNumber,
    this.adminWhatsAppNumber,
    this.transporterPhoneNumber,
    this.transporterWhatsAppNumber,
    this.vehicleIdVts,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);

  static List<DriverModel> dummy() {
    return <DriverModel>[
      DriverModel.fromJson({
        "driverId": "1",
        "driverName": "Joko Saputro",
        "memberId": 0,
        "username": null,
        "email": "joko@mail.com",
        "password": null,
        "confirmPassword": null,
        "simNumber": null,
        "gsmNumber": null,
        "phoneNumber": "087786471873",
        "phoneNumberConfirmed": false,
        "status": 1,
        "lastLoginTime": null,
        "udid": null,
        "registrationCode": "87947567954969",
        "pinHash": null,
        "insertedBy": null,
        "insertedDate": null,
        "modifiedBy": null,
        "modifiedDate": null,
        "birthDate": "1980-12-04T00:00:00",
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiIxIiwiYWN0b3J0IjoiRCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDg3Nzg2NDcxODczIiwibmJmIjoxNTgwMjgzMzMxLCJleHAiOjE1ODA4ODgxMzEsImlhdCI6MTU4MDI4MzMzMX0.ngxA7TWAbOqkJnY5EWIsR7cSpNtauLx4ElMNV-lh03U",
        "tokenExpiredTime": "2020-02-05T07:35:31.0902266Z",
        "registeredDate": "2019-12-12T00:00:00",
        "urlProfileImage":
            "http://dev.enerren.com/InovaTMSAPI/StaticFiles/drivers/drv01.jpg",
        "score": 80,
        "address": null,
        "imei": "899808075687",
        "os": "Android"
      }),
    ];
  }

  static Future<DriverModel> getInfo({
    @required String token,
  }) {
    return NetworkUtil()
        .post(System.data.apiEndPointUtil.getDriverProfile(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "bearer $token",
      "lang": System.data.resource.lang,
    }).then((onValue) {
      return DriverModel.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<bool> setToRest({
    String token,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.setToRest(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      return true;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<bool> setToActive({
    String token,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.setToActive(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      return true;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<bool> checkVehicleAbsenceDaily({
    String token,
  }) {
    //Tadi code di NetworkUtil().method nya post, karena di Api TMS "/api/Drivers/checkVehicleAbsenceDaily" nya get diganti menjadi get
    //return NetworkUtil().post(
    return NetworkUtil().post(
      System.data.apiEndPointUtil.checkVehicleAbsenceDaily(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      String result = (onValue as String);
      return result == "true"
          ? true
          : result == "false"
              ? false
              : null;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<bool> checkVehicleAttendanceDaily({
    String token,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.getcheckVehicleAttendanceDaily(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      String result = (onValue as String);
      return result == "true"
          ? true
          : result == "false"
              ? false
              : null;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<DriverModel> changeProfile({
    String token,
    DriverModel driverModel,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.updateDriverProfile(),
      body: driverModel.toJson(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      return DriverModel.fromJson(json.decode(value));
    }).catchError((onError) {
      throw onError;
    });
  }
}
