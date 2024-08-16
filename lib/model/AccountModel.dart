import 'dart:convert';
import 'dart:io';
import 'package:enerren/model/RegisterModel.dart';
import 'package:enerren/util/DateTimeUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/NetworkUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class AccountModel {
  String username;
  String password;
  String confirmPassword;
  String otpCode;
  bool activated;
  String sendTo;
  DateTime otpExpiredTime;

  AccountModel({
    this.username,
    this.password,
    this.confirmPassword,
    this.otpCode,
    this.activated,
    this.sendTo,
    this.otpExpiredTime,
  });

  AccountModel.createPasswordParam({
    @required this.username,
    @required this.password,
    @required this.confirmPassword,
    @required this.otpCode,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    ModeUtil.debugPrint(json);
    var result = AccountModel(
      username: json["username"],
      password: json["password"],
      confirmPassword: json["confirmPassword"],
      otpCode: json["otpCode"],
      activated: json["activated"],
      sendTo: json["sendTo"],
      otpExpiredTime: json["otpExpiredTime"] != null
          ? DateTimeUtil.converDate(json["otpExpiredTime"])
          : null,
    );
    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword,
      "otpCode": otpCode,
      "activated": activated,
      "sendTo": sendTo,
      "otpExpiredTime": otpExpiredTime,
    };
  }

  Map<String, dynamic> toCreatePasswordParam({
    String deviceId,
  }) {
    var param = {
      "username": username,
      "password": password,
      "confirmPassword": confirmPassword,
      "otpCode": otpCode,
    };
    param["deviceId"] = deviceId;
    return param;
  }

  static Future<AccountModel> checkAccount({
    String token,
    @required String username,
    bool isResetPassword,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.get(
      System.data.apiEndPointUtil
          .checkAccount(username: username, isResetPassword: isResetPassword),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
      },
    ).then((onValue) {
      if (onValue.toString().isNotEmpty) {
        return AccountModel.fromJson(json.decode(onValue));
      } else {
        return null;
      }
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> createPassword({
    String token,
    AccountModel account,
    String deviceId,
  }) {
    ModeUtil.debugPrint(json.encode(account.toCreatePasswordParam(
      deviceId: deviceId,
    )));
    ModeUtil.debugPrint("bearer $token");
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      System.data.apiEndPointUtil.createPassword(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: account.toCreatePasswordParam(
        deviceId: deviceId,
      ),
    )
        .then((onValue) {
      return json.decode(onValue) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> login({
    String token,
    String username,
    String password,
    String deviceId,
    String otp,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.login(
        otpCode: otp,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: {
        "userName": "${username.trim()}",
        "password": "${password.trim()}",
        "deviceId": "$deviceId"
      },
    ).then((onValue) {
      return json.decode(onValue) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> changePassword({
    @required String token,
    @required String oldPassword,
    @required String newPassword,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.changePassword(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      },
    ).then((onValue) {
      return json.decode(onValue) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> register({
    String token,
    RegisterModel registerModel,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil
        .post(
      System.data.apiEndPointUtil.register(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: registerModel.toJson(),
    )
        .then((onValue) {
      return json.decode(onValue) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<String> logout({
    String token,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.logOut(),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: {},
    ).then((onValue) {
      return onValue.toString();
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> validatePhoneNumber({
    @required String token,
    @required String phoneNumber,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.validatePhoneNUmber(
        phoneNum: phoneNumber,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: {
        "phoneNum": phoneNumber,
      },
    ).then((onValue) {
      return json.decode(onValue) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<Map<String, dynamic>> thirdPartyLogin({
    String token,
    String username,
    String fullName,
    String deviceId,
    String otp,
    String thirdPartyName,
    String thirdPartyUserId,
    String phoneNumber,
    String imageUrl,
  }) {
    NetworkUtil _netUtil = new NetworkUtil();
    return _netUtil.post(
      System.data.apiEndPointUtil.thirdPartyLogin(
        otpCode: otp,
      ),
      headers: {
        "lang": "${System.data.resource.lang}",
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: {
        "userName": "${username?.trim()}",
        "fullName": "${fullName?.trim()}",
        "deviceId": "$deviceId",
        "thirdPartyName": "$thirdPartyName",
        "thirdPartyUserId": "$thirdPartyUserId",
        "phoneNumber": "$phoneNumber",
        "imageUrl": "$imageUrl",
      },
    ).then((onValue) {
      return json.decode(onValue) as Map<String, dynamic>;
    }).catchError((onError) {
      throw onError;
    });
  }
}
