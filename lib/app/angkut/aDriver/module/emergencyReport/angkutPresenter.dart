import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/module/deliveryEmergencyReport/presenter.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin AngkutPresenter on PresenterState {
  AngkutShipmentModel data = new AngkutShipmentModel();
  VoidCallback onSuccess;

  @override
  void submitEmergency() {
    if (validate()) {
      loadingController.startLoading();
      GeolocatorUtil.myLocation().then((position) {
        ModeUtil.debugPrint(
            "lat ${position.latitude} lon ${position.longitude}");
        TmsDeliveryEmergencyInputModel emergencyInputModel =
            TmsDeliveryEmergencyInputModel(
          destinationId: data.tmsShipmentDestinationList
              .where((x) => (x.detailStatus as int) < 10)
              .toList()
              .first
              .detailshipmentId,
          vehicleId: data.tmsShipmentDestinationList
              .where((x) => (x.detailStatus as int) < 10)
              .toList()
              .first
              .vehicleId,
          driverId: data.tmsShipmentDestinationList.first.driverId,
          emergencyTime: DateTime.now(),
          emergencyNote: super.notedController.content,
          emergencyFile: super.photoController.getBase64Compress(),
          emergencyStatus: super.isCannotContinue == true ? 1 : 0,
          insertedBy: "Mobile App",
          emergencyLat: position.latitude,
          emergencyLon: position.longitude,
        );
        TmsDeliveryEmergencyModel.add(
          token: System.data.global.token,
          param: emergencyInputModel,
        ).then((onValue) {
          super.loadingController.stopLoading(
                isError: false,
                messageAlign: Alignment.topCenter,
                onFinishCallback: () {
                  if (onSuccess != null) {
                    onSuccess();
                  }
                },
                messageWidget: DecorationComponent.topMessageDecoration(
                  backgroundColor: System.data.colorUtil.greenColorOpacity,
                  message: "${System.data.resource.yourReportHasBeenSend}",
                ),
              );
          super.photoController.clear();
          super.notedController.text = "";
        }).catchError((onError) {
          super.loadingController.stopLoading(
              isError: true,
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                backgroundColor: System.data.colorUtil.redColor,
                message: "${ErrorHandlingUtil.handleApiError(onError)}",
              ));
        });
      }).catchError((onError) {
        super.loadingController.stopLoading(
            isError: true,
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.redColor,
              message: "${ErrorHandlingUtil.handleApiError(onError)}",
            ));
      });
    }
  }
}
