import 'dart:convert';

import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:enerren/module/verification/presenter.dart';

mixin NewLoginThirdPartyPresenter on PresenterState {
  ValueChanged<Map<String, dynamic>> onSuccessLogin;
  Map<String, dynamic> thirdPartyInfo;

  @override
  void onVerificationValid() {
    ModeUtil.debugPrint(
        "override onVerification valid to process new login ${System.data.global.newAccount.username} ${System.data.global.newAccount.password} ${System.data.global.mmassagingToken}");
    AccountModel.thirdPartyLogin(
      username: thirdPartyInfo[ConstantUtil.userName],
      fullName: thirdPartyInfo[ConstantUtil.fullName],
      imageUrl: thirdPartyInfo[ConstantUtil.imageUrl],
      thirdPartyName: thirdPartyInfo[ConstantUtil.thirdPartyName],
      thirdPartyUserId: thirdPartyInfo[ConstantUtil.thirdPartyUserId],
      token: System.data.global.token,
      deviceId: System.data.global.mmassagingToken,
      otp: model.verificationCode,
    ).then((onValue) {
      model.loadingController.stopLoading();
      if (onSuccessLogin != null) {
        onSuccessLogin(onValue);
      }
    }).catchError(
      (onError) {
        try {
          model.loadingController.stopLoading(
              message:
                  "${onError.body.isNotEmpty ? onError.body : onError.statusCode}");
        } catch (e) {
          model.loadingController.stopLoading(
            message: "$onError",
          );
        }
      },
    );
  }

  @override
  void resend() {
    model.loadingController.startLoading();
    AccountModel.login(
      username: System.data.global.newAccount.username,
      password: System.data.global.newAccount.password,
      token: "",
      deviceId: System.data.global.mmassagingToken,
      otp: "",
    ).then((onValue) {
      model.loadingController.stopLoading();
      if (onSuccessLogin != null) {
        onSuccessLogin(onValue);
      }
    }).catchError((onError) {
      try {
        http.Response error = onError;
        if (error.statusCode == 403) {
          model.verificationCode =
              AccountModel.fromJson(json.decode(error.body)).otpCode;
          reset();
          model.timerCountDownController.reset();
          model.timerCountDownController.start(onTick: readInbox);
          model.loadingController.stopLoading();
        } else {
          model.loadingController.stopLoading(
              message:
                  "${error.body.isNotEmpty ? error.body : error.statusCode}");
        }
      } catch (e) {
        model.loadingController.stopLoading(
          message: "$onError",
        );
      }
    });
  }
}
