import 'package:enerren/app/sierad/aDriver/localData.dart';
import 'package:enerren/model/DriverModel.dart';
import 'package:enerren/module/dashboard/presenter.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin DriverPresenter on PresenterState {
  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
    updateProfile();
  }

  currentShipment({
    ValueChanged<List<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>>
        callback,
  }) {
    loadingController.startLoading();
    SieradShipmentDetailHatcheryModel.getProcessed(
      token: System.data.global.token,
      isLowerThanId: false,
      limit: 10,
      shipmentId: null,
      withRoute: false,
    ).then((onValue) {
      if (onValue.length == 0) {
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            duration: Duration(seconds: 5),
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.redColor,
              message: "tidak ada shipment yang sedang diproses",
            ));
      } else {
        loadingController.stopLoading();
        callback(onValue);
      }
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.redColor,
            message: ErrorHandlingUtil.handleApiError(onError)),
      );
    });
  }

  void updateProfile() {
    DriverModel.getInfo(
      token: System.data.global.token,
    ).then((onValue) {
      System.data.getLocal<LocalData>().user = onValue;
      System.commit();
      // Timer.periodic((Duration(seconds: System.data.global.intervalUpdateData)),
      //     (t) {
      //   t.cancel();
      //   updateProfile();
      // });
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.redColor,
            message: ErrorHandlingUtil.handleApiError(onError,
                prefix: "Update User Info")),
      );
    });
  }

  void setToRest() {
    loadingController.startLoading();
    DriverModel.setToRest(
      token: System.data.global.token,
    ).then((onValue) {
      System.data.getLocal<LocalData>().user.isReadyToWork = false;
      System.commit();
      loadingController.stopLoading();
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void setToActive() {
    loadingController.startLoading();
    DriverModel.setToActive(
      token: System.data.global.token,
    ).then((onValue) {
      System.data.getLocal<LocalData>().user.isReadyToWork = true;
      System.commit();
      loadingController.stopLoading();
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
