import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'TmsVoucherModel.g.dart';

@JsonSerializable(explicitToJson: true)
class TmsVoucherModel {
  int discountId;
  String discountCode;
  double discountPercentage;
  double discountAmount;
  double minAmountToGetDiscount;
  double maxAmountToGetDiscount;
  double maxDiscountAmount;
  bool isUsingAmount;
  bool isActive;
  DateTime starDate;
  DateTime endDate;
  String summaryTermCondition;
  String detailTermCondition;
  String shortSescription;
  bool isPublic;
  int maxClaimed;
  int minShipmentToGetDiscount;
  int paymentMethodDetailId;
  int minDistanceToGetDiscount;
  int maxDistanceToGetDiscount;
  String urlImageIdId;
  String urlImageEnUs;

  TmsVoucherModel({
    this.discountId,
    this.discountCode,
    this.discountPercentage,
    this.discountAmount,
    this.minAmountToGetDiscount,
    this.maxAmountToGetDiscount,
    this.maxDiscountAmount,
    this.isUsingAmount,
    this.isActive,
    this.starDate,
    this.endDate,
    this.summaryTermCondition,
    this.detailTermCondition,
    this.shortSescription,
    this.isPublic,
    this.maxClaimed,
    this.minShipmentToGetDiscount,
    this.paymentMethodDetailId,
    this.minDistanceToGetDiscount,
    this.maxDistanceToGetDiscount,
    this.urlImageIdId,
    this.urlImageEnUs,
  });

  factory TmsVoucherModel.fromJson(Map<String, dynamic> data) {
    return _$TmsVoucherModelFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$TmsVoucherModelToJson(this);
  }

  String get imageVoucher {
    switch (System.data.resource.lang) {
      case "id-ID":
        return this.urlImageIdId;
        break;
      case "en-US":
        return this.urlImageEnUs;
        break;
      default:
        return null;
        break;
    }
  }

  List<String> get getTermAndCondition {
    var a = (json.decode(this.detailTermCondition) as List)
        .map((f) => (f["text"] as String))
        .toList();

    return a;
  }

  static Future<List<TmsVoucherModel>> get({
    @required String token,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.getVoucherList(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return (json.decode(onValue) as List)
            .map((f) => TmsVoucherModel.fromJson(f))
            .toList();
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<T> dynamicApply<T>({
    @required Map<String, dynamic> body,
    @required String token,
    @required ChildReader<T> dataReader,
  }) {
    return NetworkUtil().post(
      System.data.apiEndPointUtil.applyVoucher(),
      body: body,
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then((value) {
      if (value.toString().isNotEmpty) {
        return dataReader(json.decode(value.toString()));
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
