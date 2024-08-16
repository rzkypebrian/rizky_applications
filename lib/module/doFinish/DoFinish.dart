import 'package:enerren/module/do/main.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin DoFinish on PresenterState {
  @override
  void initState() {
    model.idDestination = widget.detailShipmentId;
    super.initState();
  }

  void saveDoFinishItem() {
    model.loadingController.startLoading();
    ModeUtil.debugPrint(
        model.getAllUpdate.map((f) => f.toJson()).toList().toString());
    ShipmentItemDescriptionViewModel.updateShipmentItemDescription(
      shipmentItemDescriptionViewModel: model.getAllUpdate,
      token: System.data.global.token,
    ).then((onValue) {
      model.doModelList = onValue;
      model.commit();
    }).whenComplete(() {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.greenColor,
          message: System.data.resource.yourReportHasBeenSend,
        ),
        onFinishCallback: () {
          if (widget.onSubmitSuccess != null) {
            widget.onSubmitSuccess();
          }
        },
      );
      model.commit();
    }).catchError((onError) {
      model.loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
      model.commit();
    });
  }
}
