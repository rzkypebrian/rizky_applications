import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:enerren/module/voucherDetail/main.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';

mixin AngkutPresenter on PresenterState {
  AngkutShipmentModel shipmentModel = new AngkutShipmentModel();
  ValueChanged<AngkutShipmentModel> onApply;

  @override
  void onTapApplay() {
    super.model.loadingController.startLoading();
    shipmentModel.voucherCode = super.model.voucher.discountCode;
    shipmentModel.voucherId = 0;
    TmsVoucherModel.dynamicApply(
      body: shipmentModel.toJson(),
      token: System.data.global.token,
      dataReader: (json) {
        return AngkutShipmentModel.fromJson(json);
      },
    ).then((value) {
      if (value.voucherErrorString.isNullOrEmpty()) {
        super.model.loadingController.stopLoading();
        if (onApply != null) {
          onApply(value);
        }
        super.onTapApplay();
      } else {
        super.model.loadingController.stopLoading(
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
                message: "${value.voucherErrorString}"));
      }
    }).catchError((onError) {
      super.model.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));
    });
  }
}
