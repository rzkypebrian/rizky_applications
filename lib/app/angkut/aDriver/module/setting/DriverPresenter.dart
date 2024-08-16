import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/module/setting/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin CustomerPresenter on PresenterState {
  bool statusGoHome = false;
  CircularProgressIndicatorController loadingController =
      CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  void setStatusGoHome(bool status) {
    loadingController.startLoading();
    TmsDeliveryPodModel.setBackToPool(
      token: System.data.getLocal<LocalData>().user.token,
      driverId: System.data.getLocal<LocalData>().user.driverId,
      vehicleId: null,
      status: status,
    ).then((onValue) {
      loadingController.stopLoading();
      setState(() {
        statusGoHome = status;
      });
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
