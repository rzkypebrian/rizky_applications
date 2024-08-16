import 'dart:convert';

import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/GeolocatorUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/module/deliveryPod/main.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:enerren/app/tms/util/ConstanUtil.dart' as constant;

mixin TmsDriverPresernter<T> on SignatureOnlyPresenterState {
  TmsShipmentModel<T> shipment;
  TmsDeliveryPodModel tmsDeliveryPodModel = new TmsDeliveryPodModel();
  ValueChanged<TmsShipmentModel<T>> onSuccess;

  @override
  void submit() {
    if (!validate()) return;
    super.model.loadingController.startLoading();

    GeolocatorUtil.myLocation().then((value) {
      setPod(value.latitude, value.longitude).then((onValue) {
        if (onValue.isShipmentFinish == false) {
          finishPod(false);
        } else {
          bottonConfirmBackToPool();
        }
      }).catchError(
        (onError) {
          ModeUtil.debugPrint("on set pod");
          errorHandling(onError, "on set pod");
        },
      );
    }).catchError((onError) {
      ModeUtil.debugPrint("on get location");
      errorHandling(onError, "on get location");
    });
  }

  Future<TmsDeliveryPodModel> setPod(double lat, double lon) {
    tmsDeliveryPodModel = TmsDeliveryPodModel(
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
      driverId: shipment.tmsShipmentDestinationList.first.driverId,
      driverName: shipment.tmsShipmentDestinationList.first.driverName,
      memberId: shipment.memberId,
      receiverName: super.model.receiverController.text,
      // receiverPhoto:
      //     super.model.liveCameraComponentController.value.base64Compressed,
      receiverPhoto:
          super.model.receiverImagePickerControllers.getBase64Compress(),
      barcode: super.model.barcodeController.text,
      ePODSign: super.model.signatureComponentController.getBase64,
      productPhoto:
          super.model.imagePickerControllers.getUploadedImageId().isNotEmpty
              ? null
              : super.model.imagePickerControllers.getBase64Compress(),
      isShipmentFinish: false,
      podLat: lat,
      podLon: lon,
    );
    //kirim pod
    return TmsDeliveryPodModel.set(
      token: System.data.global.token,
      param: tmsDeliveryPodModel,
    ).then((onValue) {
      return onValue;
    }).catchError((onError) {
      throw (onError);
    });
  }

  Future<TmsShipmentModel<T>> getNewDataShipment() {
    return TmsShipmentModel.getAll(
      token: System.data.global.token,
      limit: 1,
      shipmentId: shipment.tmsShipmentId,
      isLowerThanId: false,
      withRoute: true,
      destinationId: shipment.tmsShipmentDestinationList.first.detailshipmentId,
    ).then((onValue) {
      return onValue.first;
    }).catchError((onError) {
      throw (onError);
    });
  }

  void errorHandling(dynamic onError, String position) {
    super.model.loadingController.stopLoading(
          isError: true,
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError) + position,
          ),
          onFinishCallback: () {
            savePodToPendingData();
          },
        );
  }

  void savePodToPendingData() {
    //menambahkan pod time
    tmsDeliveryPodModel.podTime = DateTime.now();

    //save to panding data
    super.model.loadingController.startLoading();
    //check apakah data sudah ada
    PendingDataModel _pandingDataModel;
    Map<String, dynamic> _rawData = {
      constant.SubPandingDataType.podData: json.encode(
        tmsDeliveryPodModel.toJson(),
      ),
      constant.SubPandingDataType.shipmentData: json.encode(
        shipment.toJson(),
      ),
    };
    PendingDataModel.get(System.data.database,
            key: "${PrefsKey.pandingPod}_${shipment.tmsShipmentId}")
        .then(
      (value) {
        if (value.isEmpty) {
          _pandingDataModel = new PendingDataModel(
            key: "${PrefsKey.pandingPod}_${shipment.tmsShipmentId}",
            dataType: PendingDataType.podData,
            rawData: json.encode(_rawData),
            status: PendingDataStatus.inputNew,
          );
          _pandingDataModel.save(System.data.database).then((value) {
            super.model.loadingController.stopLoading(
                messageAlign: Alignment.topCenter,
                isError: false,
                messageWidget: DecorationComponent.topMessageDecoration(
                  message: "${System.data.resource.podSavedIntoPendingPod}",
                  backgroundColor: System.data.colorUtil.yellowColor,
                ),
                onFinishCallback: () {
                  onSuccess(shipment);
                });
          }).catchError(
            (onError) {
              super.model.loadingController.stopLoading(
                    messageAlign: Alignment.topCenter,
                    isError: true,
                    messageWidget: DecorationComponent.topMessageDecoration(
                      message: onError,
                    ),
                  );
            },
          );
        } else {
          _pandingDataModel = value.first;
          _pandingDataModel.rawData = json.encode(_rawData);
          _pandingDataModel.save(System.data.database);
          super.model.loadingController.stopLoading(
                messageAlign: Alignment.topCenter,
                isError: false,
                messageWidget: DecorationComponent.topMessageDecoration(
                  message: "${System.data.resource.podSavedIntoPendingPod}",
                  backgroundColor: System.data.colorUtil.yellowColor,
                ),
              );
        }
      },
    ).catchError(
      (onError) {
        super.model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              isError: true,
              messageWidget: DecorationComponent.topMessageDecoration(
                message: onError,
              ),
            );
      },
    );
  }

  void finishPod(bool backToPool) {
    TmsDeliveryPodModel.setBackToPool(
      token: System.data.global.token,
      status: backToPool,
      driverId: shipment.tmsShipmentDestinationList.first.driverId,
      // driverId: System.data.getLocal<LocalData>().user.driverId,
      vehicleId: shipment.tmsShipmentDestinationList.first.vehicleId,
    ).then((onValue) {
      ModeUtil.debugPrint("masuk sini");
      super.model.loadingController.stopLoading(
            isError: false,
            messageAlign: Alignment.topCenter,
            onFinishCallback: () {
              onSuccess(shipment);
            },
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.greenColor,
              message: System.data.resource.yourReportHasBeenSend,
            ),
          );
    }).catchError((onError) {
      ModeUtil.debugPrint("$onError masuk error");
      ModeUtil.debugPrint("on set back to pool");
      errorHandling(onError, "on set back to pool");
    });
  }

  void bottonConfirmBackToPool() {
    ModalComponent.bottomModalWithCorner(
      context,
      isDismissible: false,
      child: Container(
        height: 230,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset("assets/tms/back_to_pool.svg"),
            SizedBox(
              height: 30,
            ),
            Text("${System.data.resource.areYouGoingBackToPool}?"),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BottonComponent.roundedButton(
                    width: 100,
                    height: 40,
                    text: "${System.data.resource.yes}",
                    textstyle: System.data.textStyleUtil.mainLabel(
                      color: System.data.colorUtil.lightTextColor,
                    ),
                    colorBackground: System.data.colorUtil.primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                      finishPod(true);
                    }),
                SizedBox(
                  width: 30,
                ),
                BottonComponent.roundedButton(
                    width: 100,
                    height: 40,
                    text: "${System.data.resource.no}",
                    border: Border.all(
                      color: System.data.colorUtil.primaryColor,
                    ),
                    textstyle: System.data.textStyleUtil.mainLabel(),
                    colorBackground: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).pop();
                      finishPod(false);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
