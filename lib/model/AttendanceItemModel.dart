import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AttendanceItemModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AttendanceItemModel {
  String guid;
  String typeCode;
  String typeName;
  String kindOfType;
  String value;
  String checkerValue;
  String checkerReason;

  AttendanceItemModel({
    this.guid,
    this.typeCode,
    this.typeName,
    this.kindOfType,
    this.value,
    this.checkerValue,
    this.checkerReason,
  });

  factory AttendanceItemModel.fromJson(Map<String, dynamic> data) =>
      _$AttendanceItemModelFromJson(data);

  Map<String, dynamic> toJson() => _$AttendanceItemModelToJson(this);

  static Future<List<AttendanceItemModel>> getVehicleAttendance({
    @required String token,
  }) {
    return NetworkUtil()
        .get(System.data.apiEndPointUtil.getVehicleAttendanceForm(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "bearer $token",
      "lang": System.data.resource.lang,
    }).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => AttendanceItemModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
