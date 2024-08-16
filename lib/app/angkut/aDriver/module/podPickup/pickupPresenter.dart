import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/app/sierad/aDriver/module/pod/main.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

mixin PickUpPresenter on SignatureOnlyPresenterState {
  ValueChanged<AngkutShipmentModel> onFinishShipment;
  AngkutShipmentModel shipment;

  @override
  void submit() {
    if (validate()) {
      ModeUtil.debugPrint(
          "driver id driver name ${shipment.tmsShipmentDestinationList.first.driverName}");
      super.model.loadingController.startLoading();
      GeolocatorUtil.myLocation().then((value) {
        TmsDeliveryPodModel.set(
          token: System.data.global.token,
          isFinish: false,
          param: TmsDeliveryPodModel(
            destinationId:
                shipment.tmsShipmentDestinationList.first.detailshipmentId,
            driverId: shipment.tmsShipmentDestinationList.first.driverId,
            driverName: shipment.tmsShipmentDestinationList.first.driverName,
            receiverName: super.model.receiverController.text,
            receiverPhoto:
                super.model.receiverImagePickerControllers.value.uploadedId !=
                        null
                    ? null
                    : super
                        .model
                        .receiverImagePickerControllers
                        .value
                        .base64Compress,
            // super.model.liveCameraComponentController.value.base64Compressed,
            barcode: super.model.barcodeController.text,
            ePODSign: super.model.signatureComponentController.getBase64,
            productPhoto: super
                    .model
                    .imagePickerControllers
                    .getUploadedImageId()
                    .isNotEmpty
                ? null
                : super.model.imagePickerControllers.getBase64Compress(),
            isShipmentFinish: false,
            podLat: value.latitude,
            podLon: value.longitude,
          ),
        ).then((onValue) {
          super.model.loadingController.stopLoading(
                messageAlign: Alignment.topCenter,
                onFinishCallback: () {
                  nextToMaps(shipment);
                },
                messageWidget: DecorationComponent.topMessageDecoration(
                  backgroundColor: System.data.colorUtil.greenColor,
                  message: System.data.resource.yourReportHasBeenSend,
                ),
              );
        }).catchError((onError) {
          super.model.loadingController.stopLoading(
                isError: true,
                messageAlign: Alignment.topCenter,
                messageWidget: DecorationComponent.topMessageDecoration(
                  message: ErrorHandlingUtil.handleApiError(onError),
                ),
              );
        });
      }).catchError((onError) {
        super.model.loadingController.stopLoading(
              isError: true,
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                message: ErrorHandlingUtil.handleApiError(onError),
              ),
            );
      });
    }
  }

  void nextToMaps(AngkutShipmentModel angkutShipmentModel) {
    super.model.loadingController.startLoading();
    AngkutShipmentModel.submitDetailPickupOrder(
      token: System.data.global.token,
      driverId: System.data.getLocal<LocalData>().user.driverId,
      tmsshipmentId: angkutShipmentModel.tmsShipmentId,
    ).then((onValue) {
      super.model.loadingController.stopLoading();
      if (onFinishShipment != null) {
        onFinishShipment(onValue);
      }
    }).whenComplete(() {
      super.model.loadingController.stopLoading();
    }).catchError(
      (onError) {
        super.model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                message: ErrorHandlingUtil.handleApiError(onError),
              ),
              onFinishCallback: () {
                onFinishShipment(angkutShipmentModel);
              },
            );
      },
    );
  }
}
