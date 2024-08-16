import 'dart:convert';
import 'dart:io';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tmsRatingModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsRatingModel {
  int shipmentId;
  int memberId;
  double ratingValue;
  String comment;
  int driverId;
  String driverNik;
  String customerNo;

  TmsRatingModel({
    this.shipmentId,
    this.memberId,
    this.ratingValue,
    this.comment,
    this.driverId,
    this.driverNik,
    this.customerNo,
  });

  factory TmsRatingModel.fromJson(Map<String, dynamic> json) =>
      _$TmsRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TmsRatingModelToJson(this);

  static Future<TmsRatingModel> add({
    @required String token,
    TmsRatingModel param,
  }) {
    NetworkUtil _netutil = new NetworkUtil();
    return _netutil
        .post(
          System.data.apiEndPointUtil.setRating(),
          headers: {
            "lang": "${System.data.resource.lang}",
            HttpHeaders.authorizationHeader: "bearer $token",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: param.toJson(),
          encoding: Encoding.getByName("application/json"),
        )
        .then((onValue) {
          return TmsRatingModel.fromJson(json.decode(onValue));
        })
        .catchError((onError) {
      throw onError;
    });
  }
}
