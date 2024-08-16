import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';
import 'InsurancePremiModel.dart';
part 'InsuranceModel.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceModel {
  final int insuranceId;
  final String insuranceCode;
  final String insuranceName;
  final String insuranceDescription;
  final List<InsurancePremiModel> insurancePremiList;

  InsuranceModel({
    this.insuranceId,
    this.insuranceCode,
    this.insuranceName,
    this.insuranceDescription,
    this.insurancePremiList,
  });

  factory InsuranceModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceModelToJson(this);

  static Future<List<InsuranceModel>> get({
    String token,
    int insuranceTypeId,
    int insuranceId,
  }) {
    return NetworkUtil().get(
      System.data.apiEndPointUtil.getAllInsurance(
        insuranceTypeId: insuranceTypeId,
        insuranceId: insuranceId,
      ),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      on401: (response) {
        throw response;
      },
    ).then((onValue) {
      return (json.decode(onValue) as List)
          .map((f) => InsuranceModel.fromJson(f))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
