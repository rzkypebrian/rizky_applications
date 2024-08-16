import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sieradDeliverStock.g.dart';

@JsonSerializable()
class SieradDeliverStock {
  int poultryShipmentId;
  int driverId;
  String driverName;
  int qtyReceived;
  int qtyBonusReceived;
  int qtyBrokenReceived;
  int qtyBasketReceived;
  int qtyLiveBirdReceived;
  int qtyLiveBirdDead;

  SieradDeliverStock({
    this.poultryShipmentId = 0,
    this.driverId = 0,
    this.driverName,
    this.qtyReceived = 0,
    this.qtyBonusReceived = 0,
    this.qtyBrokenReceived = 0,
    this.qtyBasketReceived = 0,
    this.qtyLiveBirdReceived = 0,
    this.qtyLiveBirdDead = 0,
  });

  factory SieradDeliverStock.fromJson(Map<String, dynamic> data) =>
      _$SieradDeliverStockFromJson(data);

  Map<String, dynamic> toJson() => _$SieradDeliverStockToJson(this);

  static Future<SieradDeliverStock> set({
    @required String token,
    SieradDeliverStock param,
    bool saveToLog,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      sieradSetDeliveryStock(),
      saveToRequestLog: saveToLog,
      functionType: "Save Stock",
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: param.toJson(),
      encoding: Encoding.getByName("apliaction/json"),
    )
        .then((res) {
      return SieradDeliverStock.fromJson(json.decode(res.toString()));
    }).catchError((onError) {
      throw onError;
    });
  }

  static String sieradSetDeliveryStock() {
    return System.data.apiEndPointUtil.url + "Shipment/checkDeliverStock";
  }
}
