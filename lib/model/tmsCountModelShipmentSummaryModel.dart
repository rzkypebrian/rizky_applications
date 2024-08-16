import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsCountModelShipmentSummaryModel.g.dart';

@JsonSerializable()
class TmsCountShipmentSummaryModel {
  int process;
  int shipped;
  int finish;
  int cancel;

  TmsCountShipmentSummaryModel({
    this.process,
    this.shipped,
    this.finish,
    this.cancel,
  });

  factory TmsCountShipmentSummaryModel.fromJson(data) =>
      _$TmsCountShipmentSummaryModelFromJson(data);

  Map<String, dynamic> toJson() => _$TmsCountShipmentSummaryModelToJson(this);

  static Future<TmsCountShipmentSummaryModel> get({
    @required String token,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.getTmsShipmentSummary(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return TmsCountShipmentSummaryModel.fromJson(json.decode(onValue));
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
