import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'sieradPresenter.dart';

mixin NewLoginPresenter on SieradPresenter {
  ValueChanged<Map<String, dynamic>> onSuccessLogin;

  @override
  void onVerificationValid() {
    ModeUtil.debugPrint("override onVerification valid to process new login");
    AccountModel.login(
      username: System.data.global.newAccount.username,
      password: System.data.global.newAccount.password,
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
}
