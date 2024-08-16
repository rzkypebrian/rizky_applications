import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dashboardModel.g.dart';

@JsonSerializable(explicitToJson: true)
class DashboardModel {
  int totalVehicles;
  int vehiclesInPool;
  int movingVehicles;
  int vehiclesNeedMaintenance;

  DashboardModel({
    this.totalVehicles,
    this.vehiclesInPool,
    this.movingVehicles,
    this.vehiclesNeedMaintenance,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);

  static Future<DashboardModel> get({
    int userId,
  }) {
    return NetworkUtil().get(
        System.data.apiEndPointUtil.vehicleSummaryInovatrack(
          userId: userId,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }).then((onValue) {
      return DashboardModel.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }
}
