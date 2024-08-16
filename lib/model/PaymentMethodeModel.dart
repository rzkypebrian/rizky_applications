import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:json_annotation/json_annotation.dart';

import 'PaymentMethodeDetailModel.dart';
part 'PaymentMethodeModel.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentMethodeModel {
  @JsonKey(name: 'methodId')
  int methodId;
  @JsonKey(name: 'iconUrl')
  String iconUrl;
  @JsonKey(name: 'methodCode')
  String methodCode;
  @JsonKey(name: 'methodName')
  String methodName;
  @JsonKey(name: 'apiGuid')
  String apiGuid;
  @JsonKey(name: 'transactionFeeType')
  int transactionFeeType;
  @JsonKey(name: 'transactionFeeAmount')
  double transactionFeeAmount;
  @JsonKey(name: 'transactionFeePersentage')
  double transactionFeePersentage;
  @JsonKey(name: 'remarks')
  String remarks;
  @JsonKey(name: 'paymentMethodDetails')
  List<PaymentMethodeDetailModel> paymentMethodDetails;

  PaymentMethodeModel({
    this.methodId,
    this.iconUrl,
    this.methodCode,
    this.methodName,
    this.apiGuid,
    this.transactionFeeType,
    this.transactionFeeAmount,
    this.transactionFeePersentage,
    this.remarks,
    this.paymentMethodDetails,
  });

  factory PaymentMethodeModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodeModelToJson(this);

  static Future<List<PaymentMethodeModel>> getAll({
    String token,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .get(System.data.apiEndPointUtil.getPaymentMethod(), headers: {
      "lang": "${System.data.resource.lang}",
      HttpHeaders.authorizationHeader: "bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
    }).then((value) {
      return ((json.decode(value)) as List)
          .map((e) => PaymentMethodeModel.fromJson(e))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}
