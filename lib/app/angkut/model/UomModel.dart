import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UomModel.g.dart';

@JsonSerializable(explicitToJson: true)
class UomModel {
  String uomCode;
  String uomName;

  UomModel({
    this.uomCode,
    this.uomName,
  });

  factory UomModel.fromJson(Map<String, dynamic> json) =>
      _$UomModelFromJson(json);
  Map<String, dynamic> toJson() => _$UomModelToJson(this);

  static Future<List<UomModel>> getUOMList({
    @required String token,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.get(
      System.data.apiEndPointUtil.getUOMList(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return (json.decode(onValue) as List)
            .map((f) => UomModel.fromJson(f))
            .toList();
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }
}
