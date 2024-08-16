import 'dart:convert';
import 'dart:io';

import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
part 'CustomerModel.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerModel {
  int customerId;
  String customerNo;
  int memberId;
  String customerEmail;
  String customerName;
  String customerMobile;
  String customerAddress;
  int customerStatus;
  String customerType;
  String imageUrl;
  String password;
  String token;
  DateTime tokenExpiredTime;
  DateTime registeredDate;
  String adminPhoneNumber;
  String adminWhatsAppNumber;
  String thirdPartyName;
  String thirdPartyUserId;

  CustomerModel({
    this.customerId,
    this.customerNo,
    this.memberId,
    this.customerEmail,
    this.customerName,
    this.customerMobile,
    this.customerAddress,
    this.customerStatus,
    this.customerType,
    this.imageUrl,
    this.password,
    this.token,
    this.tokenExpiredTime,
    this.registeredDate,
    this.adminPhoneNumber,
    this.adminWhatsAppNumber,
    this.thirdPartyName,
    this.thirdPartyUserId,
  });

  factory CustomerModel.fromJson(json) => _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  static Future<CustomerModel> getProfile({
    @required String token,
  }) {
    return NetworkUtil()
        .post(System.data.apiEndPointUtil.getCustomerProfile(), headers: {
      "lang": System.data.resource.lang,
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "bearer $token",
    }).then((onValue) {
      return CustomerModel.fromJson(json.decode(onValue.toString()));
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<CustomerModel> updateProfile({
    @required String token,
    @required CustomerModel customerModel,
    String otp,
    ValueChanged<http.Response> on403,
  }) {
    return NetworkUtil()
        .post(
      System.data.apiEndPointUtil.updateCustomerProfile(
        otpCode: otp,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: customerModel.toJson(),
      on403: on403,
    )
        .then((value) {
      ModeUtil.debugPrint("update profile success");
      ModeUtil.debugPrint(value);
      return CustomerModel.fromJson(json.decode(value));
    }).catchError((onError) {
      ModeUtil.debugPrint("update profile failed");
      throw onError;
    });
  }
}
