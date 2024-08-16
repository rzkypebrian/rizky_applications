import 'package:enerren/component/AngkutDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/module/verification/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin ForgotPasswordPresenter on PresenterState {
  @override
  void resend() {
    model.loadingController.startLoading();
    AccountModel.checkAccount(
      username: System.data.global.newAccount.username,
      token: "",
      isResetPassword: true,
    ).then((onValue) {
      model.verificationCode = onValue.otpCode;
      reset();
      model.timerCountDownController.reset();
      model.timerCountDownController.start(onTick: readInbox);
      model.loadingController.stopLoading();
    }).catchError((onError) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }
}
