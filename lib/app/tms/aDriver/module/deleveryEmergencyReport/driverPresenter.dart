import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

import 'package:enerren/module/deliveryEmergencyReport/presenter.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:http/http.dart' as http;

mixin DriverPresenter<T> on PresenterState {
  TmsShipmentModel<T> data;
  VoidCallback onSuccess;

  @override
  void submitEmergency() {
    if (validate()) {
      loadingController.startLoading();
      TmsDeliveryEmergencyModel.add(
          token: System.data.global.token,
          param: TmsDeliveryEmergencyInputModel(
            destinationId:
                data.tmsShipmentDestinationList.first.detailshipmentId,
            emergencyFile: super.photoController.getBase64Compress(),
            emergencyNote: super.notedController.content,
            emergencyStatus: super.isCannotContinue == true ? 1 : 0,
            emergencyTime: DateTime.now(),
            insertedBy: "Mobile App",
            memberId: data.memberId,
            vehicleNumber: data.tmsShipmentDestinationList.first.vehicleNo,
            driverId: data.tmsShipmentDestinationList.first.driverId,
          )).then((onValue) {
        super.loadingController.stopLoading(
              isError: false,
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                backgroundColor: System.data.colorUtil.greenColorOpacity,
                message: "${System.data.resource.yourReportHasBeenSend}",
              ),
            );
        super.photoController.clear();
        super.notedController.text = "";
        if (onSuccess != null) {
          onSuccess();
        }
      }).catchError((onError) {
        try {
          http.Response response = onError;
          super.loadingController.stopLoading(
              isError: true,
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                backgroundColor: System.data.colorUtil.redColor,
                message:
                    "${response.body.isNotEmpty ? response.body : response.statusCode}",
              ));
        } catch (e) {
          super.loadingController.stopLoading(
              isError: true,
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                backgroundColor: System.data.colorUtil.redColor,
                message: "$onError",
              ));
        }
      });
    }
  }
}
