import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart' as shipment;
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/module/trackShipment/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin AngkutPresenter<AngkutShipmentModel>
    on PresenterState<AngkutShipmentModel> {
  void initState() {
    super.initState();
    loadingController.stopLoading();
  }

  @override
  void submit(String receipeNumber) {
    loadingController.startLoading();
    shipment.AngkutShipmentModel.getByNumber(
      token: System.data.global.token,
      shipmentNumber: receipeNumber.trim(),
    ).then((onValue) {
      ModeUtil.debugPrint(onValue);
      loadingController.stopLoading();
      super.result = (onValue as AngkutShipmentModel);
      safeHistory(receipeNumber);
      if (widget.onShipmentFound != null) {
        widget.onShipmentFound(super.result);
      } else {
        ModeUtil.debugPrint("on shipment found");
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
