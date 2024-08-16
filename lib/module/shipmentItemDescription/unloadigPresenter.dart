import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

mixin UnloadingPresenter on PresenterState {
  @override
  void getData() {
    loadingController.startLoading();
    ShipmentItemDescriptionViewModel.unloadingShipmentItemDescription(
      token: widget.token,
      tmsShipmentId: widget.tmsShipmentId,
      detailDestinationId: widget.destinationId,
    ).then((value) {
      loadingController.stopLoading();
      model.shipmentItemDescriptions = value;
      model.commit();
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  @override
  void onTapViewPOD() {
    loadingController.startLoading();
    TmsDeliveryPodModel.getUnloadingPOD(
      token: widget.token,
      destinationId: widget.destinationId ??
          model.shipmentItemDescriptions.first.detailshipmentId,
    ).then((value) {
      loadingController.stopLoading();
      if (value.memberId == null && value.destinationId == 0) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.yellowColor,
            messageStyle: System.data.textStyleUtil.mainLabel(),
            message: ErrorHandlingUtil.handleApiError(
              System.data.resource.dataIsEmoty,
            ),
          ),
        );
      } else {
        loadingController.stopLoading();
        if (widget.onTapViewPOD != null) {
          widget.onTapViewPOD(value);
        } else {
          ModeUtil.debugPrint("on tap view pod ${value.toJson()}");
        }
      }
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
