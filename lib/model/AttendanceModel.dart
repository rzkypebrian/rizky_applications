import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:enerren/model/AttendanceItemModel.dart';
part 'AttendanceModel.g.dart';

@JsonSerializable(explicitToJson: true)
class AttendanceModel {
  int driverId;
  String driverName;
  int vehicleIdVts;
  String vehicleTypeName;
  String vehicleNumber;
  String reason;
  DateTime attDate;
  double attendanceLat;
  double attendanceLon;
  bool isPassed;
  List<AttendanceItemModel> listItemAttendance;

  AttendanceModel({
    this.driverId,
    this.driverName,
    this.vehicleIdVts,
    this.vehicleTypeName,
    this.vehicleNumber,
    this.reason,
    this.attDate,
    this.attendanceLat,
    this.attendanceLon,
    this.isPassed,
    this.listItemAttendance,
  }) {
    this.listItemAttendance = this.listItemAttendance ?? [];
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);

  static Future<AttendanceModel> add({
    String token,
    AttendanceModel attendanceModel,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      System.data.apiEndPointUtil.addAttendance(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: attendanceModel.toJson(),
    )
        .then((onValue) {
      return AttendanceModel.fromJson(
          json.decode(onValue) as Map<String, dynamic>);
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<AttendanceModel> confirm({
    String token,
    AttendanceModel attendanceModel,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      System.data.apiEndPointUtil.confirmAttendance(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: attendanceModel.toJson(),
    )
        .then((onValue) {
      return AttendanceModel.fromJson(
          json.decode(onValue) as Map<String, dynamic>);
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<AttendanceModel>> dailyAttendance({
    String token,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.get(
      System.data.apiEndPointUtil.dailyAttendace(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      return (json.decode(onValue) as List)
          .map((e) => AttendanceModel.fromJson((e) as Map<String, dynamic>))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }

  static List<AttendanceModel> attendancelistDummy = [
    AttendanceModel(
      driverId: 1,
      driverName: "Mardigu",
      vehicleNumber: "B 6745 TU",
      vehicleTypeName: "Pick Up Box",
      attDate: DateTime.now(),
      isPassed: null,
    ),
    AttendanceModel(
      driverId: 2,
      driverName: "Mardigu",
      vehicleNumber: "B 6745 TU",
      vehicleTypeName: "Pick Up Box",
      attDate: DateTime.now(),
      isPassed: null,
    ),
    AttendanceModel(
      driverId: 3,
      driverName: "Mardigu",
      vehicleNumber: "B 6745 TU",
      vehicleTypeName: "Pick Up Box",
      attDate: DateTime.now(),
      isPassed: true,
    ),
    AttendanceModel(
      driverId: 4,
      driverName: "Mardigu",
      vehicleNumber: "B 6745 TU",
      vehicleTypeName: "Pick Up Box",
      attDate: DateTime.now(),
      isPassed: false,
    ),
  ];
}
