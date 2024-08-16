import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
part 'insuranceCategoryModel.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuraceCategoryModel {
  int insuranceTypeId;
  String insuranceTypeName;
  int insuranceId;
  String insuranceName;
  bool isActive;

  InsuraceCategoryModel({
    this.insuranceTypeId,
    this.insuranceTypeName,
    this.insuranceId,
    this.insuranceName,
    this.isActive,
  });

  factory InsuraceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$DriverRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverRatingModelToJson(this);

  static Future<List<InsuraceCategoryModel>> get({
    String token,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.getAllInsuranceCategory(),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      on401: (response) {
        throw response;
      },
    ).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => InsuraceCategoryModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
