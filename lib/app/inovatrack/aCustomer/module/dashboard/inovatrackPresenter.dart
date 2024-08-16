import 'dart:async';

import 'package:enerren/app/inovatrack/aCustomer/localData.dart';
import 'package:enerren/app/inovatrack/model/dashboardModel.dart';
import 'package:enerren/app/inovatrack/aCustomer/module/dashboard/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';

mixin InovatrackPresenter on PresenterState {
  ViewModel model = new ViewModel.dummy();

  @override
  void initState() {
    super.initState();
    getSummary();
  }

  void getSummary({bool withLoading = true, bool continuously = true}) {
    if (withLoading) loadingController.startLoading();
    DashboardModel.get(
      userId: System.data.getLocal<LocalData>().user.userId,
    ).then((onValue) {
      model.movingVehicles = onValue.movingVehicles;
      model.inPoolVehicles = onValue.vehiclesInPool;
      model.maintenanceVehicles = onValue.vehiclesNeedMaintenance;
      model.commit();
      loadingController.stopLoading();
      if (!continuously) return;
      Timer.periodic(Duration(seconds: 1000), (t) {
        getSummary(
          withLoading: false,
        );
      });
    }).catchError((onError) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ));
    });
  }
}
