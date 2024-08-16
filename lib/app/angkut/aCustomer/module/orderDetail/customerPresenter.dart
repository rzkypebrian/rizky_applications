import 'dart:async';

import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/angkut/module/orderDetail/main.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/bottomDockComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin CustomerPresenter on PresenterState {
  ValueChanged<AngkutShipmentModel> onTapPaynow;

  EdgeInsetsGeometry bottomSheetContentPadding = EdgeInsets.all(0);
  double bottomSheetHeight = 170;
  BottomDockComponentController bottomSheetController =
      new BottomDockComponentController();

  bool finishTimer = false;
  bool dockExpand = true;
  Timer timer;

  @override
  void initState() {
    super.initState();
    doTimer();
  }

  void cancleOrder() {
    loadingController.startLoading();
    if (model.shipment.shipmentStatusId >= 3) {
      loadingController.startLoading();
      loadingController.startLoading();
      VtsPositionModel.getVehiclePosition(
        vehicleId:
            super.model.shipment.tmsShipmentDestinationList.first.vehicleIdVts,
      ).then((position) {
        cancleShipment(position);
      }).catchError((onErrorPosition) {
        loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onErrorPosition,
                  prefix:
                      "${System.data.resource.cancel} ${System.data.resource.shipment}"),
            ));
      });
    } else {
      cancleShipment(null);
    }
  }

  void cancleShipment(VtsPositionModel position) {
    AngkutShipmentModel.cancleShipment(
      token: System.data.global.token,
      shipmentId: super.model.shipment?.tmsShipmentId,
      vehicleLat: position?.lat,
      vehicleLon: position?.lon,
      vehicleOdometer: position?.odometer?.toInt(),
    ).then((shipment) {
      finishTimer = true;
      super.model.commit();
      loadingController.startLoading();
      if (widget.onSuccessCancel != null) {
        widget.onSuccessCancel();
      } else {
        ModeUtil.debugPrint("cancel success");
      }
    }).catchError((onErrorShipment) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onErrorShipment,
                prefix:
                    "${System.data.resource.cancel} ${System.data.resource.shipment}"),
          ));
    });
  }

  void doTimer() async {
    print("masuk sini memulai timer ${model.shipment.shipmentStatusId}");
    if (model.shipment.shipmentStatusId >= 3 &&
        model.shipment.deadlineCancelledDatetime != null &&
        model.shipment.shipmentStatusId <= 6 &&
        model.shipment.isConfirmWaiting != true) {
      var diff =
          (model.shipment.deadlineCancelledDatetime).difference(DateTime.now());
      ModeUtil.debugPrint("run tick $diff");
      timer = Timer(
        diff,
        () {
          finishTimer = true;
          model.commit();
          timer.cancel();
        },
      );
    } else {
      finishTimer = true;
      model.commit();
    }
  }

  void confirmWaiting() {
    loadingController.startLoading();
    AngkutShipmentModel.confirmWaiting(
      shipmentNumber: model.shipment.tmsShipmentId,
      token: System.data.global.token,
    ).then((onValue) {
      model.shipment = onValue;
      model.commit();
      timer.cancel();
      loadingController.stopLoading();
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }
}
