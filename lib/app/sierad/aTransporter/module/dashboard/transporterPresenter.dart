import 'dart:async';

import 'package:enerren/app/sierad/aTransporter/localData.dart';
import 'package:enerren/app/sierad/module/dashboard/main.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/TransporterModel.dart';
import 'package:enerren/model/tmsVehicleStatusSummary.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';

mixin TransporterPresenter on PresenterState {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    super.initState();
    super.loadingController.stopLoading();
    getVehicleStatusSUmmary();
    getProfile();
  }

  void getVehicleStatusSUmmary() {
    TmsVehicleStatusSummary.get(
      token: System.data.global.token,
    ).then((onValue) {
      model.vehicleStatusSummary = onValue;
      model.commit();
      Timer.periodic(Duration(seconds: System.data.global.intervalUpdateData),
          (t) {
        getVehicleStatusSUmmary();
        t.cancel();
      });
    }).catchError(
      (onError) {
        super.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                message: ErrorHandlingUtil.handleApiError(onError),
              ),
            );
      },
    );
  }

  void getProfile() {
    TransporterModel.getProfile(
      token: System.data.global.token,
    ).then((onValue) {
      System.data.getLocal<LocalData>().user = onValue;
      System.commit();
    }).catchError((onError) {
      super.loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(
                onError,
                prefix: "get profile",
              ),
            ),
          );
    });
  }
}
