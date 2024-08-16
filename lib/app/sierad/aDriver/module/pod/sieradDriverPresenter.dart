import 'dart:convert';

import 'package:enerren/component/BottonComponent.dart';
import 'package:enerren/component/ModalComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/app/sierad/model/sieradDeliverStock.dart';
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
import 'package:enerren/app/sierad/util/ConstanUtil.dart' as constant;

mixin SieradDriverPresernter on SignatureOnlyPresenterState {
  TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment;
  SieradDeliverStock stock;
  TmsDeliveryPodModel tmsDeliveryPodModel = new TmsDeliveryPodModel();
  ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>> onSuccess;
  PendingDataModel pendingDataModel;

  @override
  void submit() {
    if (!validate()) return;
    model.loadingController.startLoading();

    // 1 save to pending data first
    try {
      try {
        GeolocatorUtil.myLocation().then((value) {
          setPod(value.latitude, value.longitude);
        }).catchError((onError) {
          ModeUtil.debugPrint("on get location");
          errorHandling(onError, "on get location");
        });
      } catch (e) {
        // errorHandling(e.toString(), "on get location");
      }
    } catch (e) {
      errorHandling(e.toString(), "on get location");
    }
  }

  void setPod(double lat, double lon) {
    try {
      tmsDeliveryPodModel = TmsDeliveryPodModel(
        destinationId:
            shipment.tmsShipmentDestinationList.first.detailshipmentId,
        driverId: shipment.tmsShipmentDestinationList.first.driverId,
        // driverId: System.data.getLocal<LocalData>().user.driverId,
        driverName: shipment.tmsShipmentDestinationList.first.driverName,
        memberId: shipment.memberId,
        receiverName: super.model.receiverController.text,
        receiverPhoto:
            // super.model.liveCameraComponentController.value.base64Compressed,
            super.model.receiverImagePickerControllers.value.uploadedId != null
                ? null
                : super
                    .model
                    .receiverImagePickerControllers
                    .value
                    .base64Compress,
        barcode: super.model.barcodeController.text,
        ePODSign: null,
        productPhoto:
            super.model.imagePickerControllers.getUploadedImageId().isNotEmpty
                ? null
                : super.model.imagePickerControllers.getBase64Compress(),
        podLat: lat,
        podLon: lon,
      );
      print("Finish collect data ");
      savePodToPendingData(
        onSuccess: () {
          print("send pod sign");
          super.model.signatureComponentController.upload(
            System.data.apiEndPointUtil.getPODUploadSignature(
                destinationId:
                    shipment.tmsShipmentDestinationList.first.detailshipmentId),
            field: "File",
            token: "bearer ${System.data.global.token}",
            onUploaded: (result) {
              // print("save to pending data success");
              TmsDeliveryPodModel.set(
                token: System.data.global.token,
                param: tmsDeliveryPodModel,
                saveToLog: true,
              ).then((onValue) {
                print("remove from pending pod");
                super.model.loadingController.stopLoading(
                    message: System.data.resource.yourOrderHasBeenSent,
                    messageAlign: Alignment.topCenter,
                    messageWidget: DecorationComponent.topMessageDecoration(
                      backgroundColor: System.data.colorUtil.greenColor,
                      message: System.data.resource.yourOrderHasBeenSent,
                    ),
                    onFinishCallback: () {
                      removeItem(
                        pendingDataModel: pendingDataModel,
                        onSuccess: () {
                          if (onValue.isShipmentFinish == false) {
                            finishPod(false);
                          } else {
                            bottonConfirmBackToPool();
                          }
                        },
                      );
                    });
              }).catchError((onError) {
                errorHandling(onError, "set POD");
              });
            },
            onUploaderror: (result) {
              errorHandling(result.toString(), "on upload signature");
            },
          );
        },
      );
      //kirim pod
    } catch (e) {
      errorHandling(e.toString(), "coolect data");
    }
  }

  Future<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      getNewDataShipment() {
    return SieradShipmentDetailHatcheryModel.getAll(
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

  Future<bool> saveStock() {
    return SieradDeliverStock.set(token: System.data.global.token, param: stock)
        .then((onValue) {
      return true;
    }).catchError((onError) {
      throw (onError);
    });
  }

  void errorHandling(dynamic onError, String position) {
    super.model.loadingController.stopLoading(
          isError: true,
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError) + " " + position,
          ),
          // onFinishCallback: () {
          //   savePodToPendingData();
          // },
        );
  }

  void savePodToPendingData({
    VoidCallback onSuccess,
  }) {
    try {
      //menambahkan pod time
      tmsDeliveryPodModel.podTime = DateTime.now();

      //save to panding data
      super.model.loadingController.startLoading();
      PendingDataModel _pandingDataModel;
      Map<String, dynamic> _rawData = {
        constant.SubPandingDataType.podData: json.encode(
          tmsDeliveryPodModel.toJson(),
        ),
        constant.SubPandingDataType.shipmentData: json.encode(
          shipment.toJson(),
        ),
        constant.SubPandingDataType.stockData: json.encode(
          stock.toJson(),
        ),
      };
      _pandingDataModel = new PendingDataModel(
        key: "${shipment.tmsShipmentDestinationList.first.detailshipmentId}",
        dataType: PendingDataType.podData,
        rawData: json.encode(_rawData),
        status: PendingDataStatus.inputNew,
      );
      _pandingDataModel.saveToFile().then((value) {
        pendingDataModel = value;
        super.model.loadingController.stopLoading();
        onSuccess();
      }).catchError(
        (onError) {
          super.model.loadingController.stopLoading(
                // messageMode: MessageMode.Popup,
                message: onError.toString(),
              );
        },
      );
    } catch (e) {
      errorHandling(e.toString(), "collect pending data");
    }
  }

  removeItem({PendingDataModel pendingDataModel, VoidCallback onSuccess}) {
    model.loadingController.startLoading();
    model.commit();
    pendingDataModel.removeFromFile().then((value) {
      model.loadingController.stopLoading();
      onSuccess();
      model.commit();
    }).catchError((onError) {
      pendingDataModel.status = PendingDataStatus.failed;
      model.loadingController.stopLoading();
      model.commit();
    });
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
      saveStock().then((value) {
        getNewDataShipment().then((onValue) {
          super.model.loadingController.stopLoading(
                isError: false,
                messageAlign: Alignment.topCenter,
                onFinishCallback: () {
                  onSuccess(onValue);
                },
                messageWidget: DecorationComponent.topMessageDecoration(
                  backgroundColor: System.data.colorUtil.greenColor,
                  message: System.data.resource.yourReportHasBeenSend,
                ),
              );
        }).catchError((onError) {
          ModeUtil.debugPrint("on get new shipment");
          errorHandling(onError, "on get new shipment");
        });
      }).catchError((onError) {
        ModeUtil.debugPrint("on save stock");
        errorHandling(onError, "on save stock");
      });
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
            SvgPicture.asset("assets/sierad/back_to_pool.svg"),
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
