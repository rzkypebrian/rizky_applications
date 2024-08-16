import 'package:enerren/app/sierad/aDriver/localData.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/module/profile/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin UpdateDriverPresenter on PresenterState {
  bool validate() {
    bool valid = true;
    // valid = validateName() ?? valid;
    // valid = validateEmail() ?? valid;
    // valid = validatePhone() ?? valid;
    // valid = validateAddress() ?? valid;
    return valid;
  }

  void submit() {
    ModeUtil.debugPrint("masuk sini");
    DriverModel driver = System.data.getLocal<LocalData>().user;
    if (validate()) {
      driver.urlProfileImage = imagePickerController.getBase64();
      loadingController.startLoading();
      DriverModel.changeProfile(
        token: System.data.global.token,
        driverModel: driver,
      ).then((value) {
        System.data.getLocal<LocalData>().user = value;
        System.commit();
        widget.onUpdateSuccess(profileModel);
      }).catchError((onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      });
    }
  }
}
