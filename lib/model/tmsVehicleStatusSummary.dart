import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsVehicleStatusSummary.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsVehicleStatusSummary {
  int rest;
  int standby;
  int order;

  TmsVehicleStatusSummary({
    this.rest,
    this.standby,
    this.order,
  });

  factory TmsVehicleStatusSummary.fromJson(Map<String, dynamic> json) =>
      _$TmsVehicleStatusSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$TmsVehicleStatusSummaryToJson(this);

  static Future<TmsVehicleStatusSummary> get({
    String token,
  }) {
    return NetworkUtil()
        .post(System.data.apiEndPointUtil.vehicleStatusSummary(), headers: {
      "lang": System.data.resource.lang,
      HttpHeaders.authorizationHeader: "bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
    }).then((onValue) {
      return TmsVehicleStatusSummary.fromJson(json.decode(onValue));
    }).catchError((onError) {
      throw onError;
    });
  }
}
