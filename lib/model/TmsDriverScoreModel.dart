import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TmsDriverScoreModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsDriverScoreModel {
  int driverId;
  String driverName;
  double driverScore;
  int cancelShipment;
  int finishShipment;
  int overSpeed;
  double averageSpeed;

  TmsDriverScoreModel({
    this.driverId,
    this.driverName,
    this.driverScore,
    this.cancelShipment,
    this.finishShipment,
    this.overSpeed,
    this.averageSpeed,
  });

  factory TmsDriverScoreModel.fromJson(Map<dynamic, dynamic> json) =>
      _$TmsDriverScoreModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$TmsDriverScoreModelToJson(this);

  static Future<TmsDriverScoreModel> get({
    String token,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.driverScore(),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
        "lang": "${System.data.resource.lang}",
      },
    ).then((onValue) {
      return TmsDriverScoreModel.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }
}
