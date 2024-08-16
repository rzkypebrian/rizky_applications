import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/AccountModel.dart';
import 'package:enerren/module/setting/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';

mixin DriverPresenter on PresenterState {
  bool statusGoHome = false;
  CircularProgressIndicatorController loadingController =
      CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  @override
  void signOut(VoidCallback callback) {
    System.data.routes.pop(context);
    loadingController.startLoading();
    AccountModel.logout(
      token: System.data.global.token,
    ).then((onValue) {
      loadingController.stopLoading();
      if (System.data.getLocal<LocalData>().user.thirdPartyName ==
          ConstantUtil.loginByGoogle) {
        System.data.googleSign.disconnect().then((value) {
          if (callback != null) {
            callback();
          }
        });
      } else if (System.data.getLocal<LocalData>().user.thirdPartyName ==
          ConstantUtil.loginByFacebook) {
        System.data.facebookLogin.logout().then((value) {
          if (callback != null) {
            callback();
          }
        });
      }
    }).catchError((onError) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ));
    });
  }
}
