import 'package:enerren/app/angkut/aDriver/localData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/VtsPositionModel.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'ViewModel.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<ViewModel> onTapReceive;
  final ValueChanged<AngkutShipmentModel> onTapLiveMap;
  final AngkutShipmentModel shipment;
  final ValueChanged2Param<AngkutShipmentModel, TmsDeliveryEmergencyModel>
      onTapDriver;
  final VoidCallback onSuccessCancel;
  final ValueChanged2Param<AngkutShipmentModel, int> onTapLoadingDetail;
  final ValueChanged2Param<AngkutShipmentModel, int> onTapUnloadingDetail;
  final bool showShipmentNumber;
  final bool showPaymentDetail;
  final bool showVoucherDetail;
  final bool showContactPerson;
  final bool showInchargeStatus;
  final bool showTripReport;

  final ValueChanged<TripAllowanceSummary> onTapTripReport;

  const Presenter({
    Key key,
    this.view,
    this.onTapReceive,
    this.shipment,
    this.onTapLiveMap,
    this.onTapDriver,
    this.onTapLoadingDetail,
    this.onTapUnloadingDetail,
    this.showShipmentNumber = true,
    this.showPaymentDetail = true,
    this.showContactPerson = true,
    this.showInchargeStatus = true,
    this.showTripReport = true,
    this.onTapTripReport,
    this.onSuccessCancel,
    this.showVoucherDetail = true,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();
  int vehicleId;
  int vehicleIdVts;
  int driverId;

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
    if (widget.shipment != null) {
      print("shipment from route ${widget.shipment.shipmentStatusId}");
      model.shipment = widget.shipment;
      model.commit();
    }
  }

  void onReceive() {
    ModeUtil.debugPrint("receive shipment");
    loadingController.startLoading();
    VtsPositionModel.getVehiclePosition(
            vehicleId: vehicleIdVts ??
                System.data.getLocal<LocalData>().user.vehicleIdVts)
        .then((onValue) {
      AngkutShipmentModel.acceptShipment(
        token: System.data.global.token,
        driverId: driverId ?? System.data.getLocal<LocalData>().user.driverId,
        shipmentId: model.shipment.tmsShipmentId,
        vehicleLat: onValue.lat,
        vehicleLon: onValue.lon,
        vehicleOdometer: onValue.odometer.toInt(),
        vahicleId:
            vehicleIdVts ?? System.data.getLocal<LocalData>().user.vehicleIdVts,
      ).then((onValue) {
        loadingController.stopLoading();
        model.shipment = onValue;
        ModeUtil.debugPrint(
            "vehicle id is ${onValue.tmsShipmentDestinationList.first.vehicleIdVts}");
        model.shipment = onValue;
        model.commit();
        onTapTrack();
      }).catchError((onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.redColor,
            message: ErrorHandlingUtil.handleApiError(onError,
                prefix: "Accept Order"),
          ),
        );
      });
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.redColor,
          message: ErrorHandlingUtil.handleApiError(
            onError,
            prefix: "get position",
          ),
        ),
      );
    });
  }

  void onTapTrack() {
    if (widget.onTapLiveMap != null) {
      widget.onTapLiveMap(model.shipment);
    }
  }

  void ontapPickupDetail(int destinationId) {
    if (widget.onTapLoadingDetail != null) {
      widget.onTapLoadingDetail(widget.shipment, destinationId);
    } else {
      print("on tap shipment loading detail tapped");
    }
  }

  void onTapUnloadingDetail(int destinationId) {
    if (widget.onTapUnloadingDetail != null) {
      widget.onTapUnloadingDetail(widget.shipment, destinationId);
    } else {
      print("on tap shipment unloading detail tapped");
    }
  }

  void getShipmentReport() {
    loadingController.startLoading();
    TripAllowanceSummary.getUangJalanList(
      token: System.data.global.token,
      shipmentNumber: widget.shipment.shipmentNumber,
    ).then(
      (value) {
        print(value);
        loadingController.stopLoading();
        if (widget.onTapTripReport != null) {
          widget.onTapTripReport(value.first);
        }
      },
    ).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          backgroundColor: System.data.colorUtil.redColor,
          message: ErrorHandlingUtil.handleApiError(
            onError,
            prefix: "get trip report",
          ),
        ),
      );
    });
  }

  void cancleOrder() {
    loadingController.startLoading();
    if (model.shipment.shipmentStatusId >= 3) {
      loadingController.startLoading();
      loadingController.startLoading();
      VtsPositionModel.getVehiclePosition(
        vehicleId: model.shipment.tmsShipmentDestinationList.first.vehicleIdVts,
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
      shipmentId: model.shipment?.tmsShipmentId,
      vehicleLat: position?.lat,
      vehicleLon: position?.lon,
      vehicleOdometer: position?.odometer?.toInt(),
    ).then((shipment) {
      model.commit();
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
}
