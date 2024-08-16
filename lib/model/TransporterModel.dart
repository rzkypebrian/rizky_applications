import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TransporterModel.g.dart';

//run in terminal : flutter pub run build_runner build => for generate json map data
//run in terminal : flutter pub get => run this if the above code fails
//delete .dart_tool and delete all .g.dart file in model if if the above code fails
@JsonSerializable(explicitToJson: true)
class TransporterModel {
  int transporterId;
  String transporterCode;
  int memberId;
  String transporterName;
  int transporterGeofenceId;
  String transporterContact;
  String transporterMobile;
  int transporterIdVts;
  String transporterTokenVts;
  int status;
  String transporterType;
  String transporterEmail;
  String password;
  DateTime birthDate;
  String imageUrl;
  String address;
  String token;
  DateTime tokenExpiredTime;
  DateTime registeredDate;
  String imei;
  String os;
  String adminPhoneNumber;
  String adminWhatsAppNumber;

  TransporterModel({
    this.transporterId,
    this.transporterCode,
    this.memberId,
    this.transporterName,
    this.transporterGeofenceId,
    this.transporterContact,
    this.transporterMobile,
    this.transporterIdVts,
    this.transporterTokenVts,
    this.status,
    this.transporterType,
    this.transporterEmail,
    this.password,
    this.birthDate,
    this.imageUrl,
    this.address,
    this.token,
    this.tokenExpiredTime,
    this.registeredDate,
    this.imei,
    this.os,
    this.adminPhoneNumber,
    this.adminWhatsAppNumber,
  });

  factory TransporterModel.fromJson(data) => _$TransporterModelFromJson(data);

  Map<String, dynamic> toJson() => _$TransporterModelToJson(this);

  static Future<TransporterModel> getProfile({
    @required String token,
  }) {
    return NetworkUtil()
        .post(System.data.apiEndPointUtil.getTransporterProfile(), headers: {
      "lang": System.data.resource.lang,
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "bearer $token",
    }).then((onValue) {
      return TransporterModel.fromJson(json.decode(onValue as String));
    }).catchError((onError) {
      throw onError;
    });
  }
}
