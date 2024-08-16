import 'dart:async';

import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/tmsVehicleStatusSummary.dart';
import 'package:enerren/module/dashboard/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';

mixin AngkutPresenter on PresenterState {
  ViewModel model = new ViewModel();
  CircularProgressIndicatorController dashboardLoadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    dashboardLoadingController.stopLoading();
    getVehicleStatusSUmmary();
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
}
