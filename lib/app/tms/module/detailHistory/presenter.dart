import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/tmsDecorationComponent.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/model/TripAllowanceSummaryModel.dart';
import 'package:enerren/model/tmsDeliveryEmergencyModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter<T> extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TmsShipmentModel<T>> onTapTrack;
  final String finisButtonLabel;
  final ValueChanged<TmsShipmentModel<T>> onTapFinish;
  final ValueChanged<TmsShipmentModel<T>> onTapPendingPod;
  final TmsShipmentModel<T> data;
  final ValueChanged2Param<TmsShipmentModel<T>, int> onTapLoadingDetail;
  final ValueChanged2Param<TmsShipmentModel<T>, int> onTapUnloadingDetail;
  final ValueChanged<TmsShipmentModel> onTapAddTripAllowance;
  final ValueChanged<TripAllowanceSummary> onTapViewTripAllowance;
  final Widget originIcon;
  final Widget destinationIcon;
  final bool showButtonAddTripAllowanceBalance;
  final bool showButtonViewTripAllowanceBalance;
  final bool showContactPerson = false;
  final bool showInchargeStatus = false;
  final ValueChanged2Param<TmsShipmentModel, TmsDeliveryEmergencyModel>
      onTapDriver;

  const Presenter({
    Key key,
    this.view,
    this.onTapTrack,
    this.data,
    this.onTapFinish,
    this.finisButtonLabel,
    this.onTapUnloadingDetail,
    this.onTapPendingPod,
    this.originIcon,
    this.destinationIcon,
    this.onTapAddTripAllowance,
    this.onTapViewTripAllowance,
    this.showButtonAddTripAllowanceBalance,
    this.onTapLoadingDetail,
    this.showButtonViewTripAllowanceBalance = true,
    this.onTapDriver,
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
  int status = 1; // 1 selesai 2 proses 3 reject
  ViewModel model = new ViewModel();
  CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    loadingController.stopLoading();
    initData();
  }

  void initData() {
    model.shipment = widget.data;
  }

  void finishShipment() {
    if (widget.onTapFinish != null) {
      widget.onTapFinish(model.shipment);
    }
  }

  void pendingPod() {
    if (widget.onTapFinish != null) {
      widget.onTapPendingPod(model.shipment);
    }
  }

  void trackss() {
    if (widget.onTapTrack != null) {
      widget.onTapTrack(model.shipment);
    } else {
      ModeUtil.debugPrint("track");
    }
  }

  void refresh() {
    TmsShipmentModel.getAll(
      destinationId:
          model.shipment.tmsShipmentDestinationList.first.detailshipmentId,
      token: System.data.global.token,
      limit: 1,
      shipmentId: model.shipment.tmsShipmentDestinationList.first.tmsShipmentId,
      withRoute: true,
      isLowerThanId: false,
    ).then((onValue) {
      model.shipment = onValue.first;
      model.commit();
    }).catchError((onError) {
      loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
              message: ErrorHandlingUtil.handleApiError(onError)));
    });
  }

  Future<bool> checkPandingPod() {
    return PendingDataModel.get(System.data.database,
            key: "${PrefsKey.pandingPod}_${model.shipment.tmsShipmentId}")
        .then((value) {
      if (value.length > 0) {
        loadingController.stopLoading(
            duration: Duration(
              days: 1,
            ),
            messageAlign: Alignment.topCenter,
            messageWidget: DecorationComponent.topMessageDecoration(
              backgroundColor: System.data.colorUtil.yellowColor,
              message:
                  "${System.data.resource.podFailedToSendEndSavedInPendingPod}",
            ));
        return true;
      } else {
        return false;
      }
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  void tripReport() {
    loadingController.startLoading();
    TripAllowanceSummary.getUangJalanList(
      token: System.data.global.token,
      shipmentNumber: model.shipment.shipmentNumber,
    ).then(
      (value) {
        print(value);
        loadingController.stopLoading();
        if (widget.onTapViewTripAllowance != null) {
          if (value.isEmpty) {
            loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                backgroundColor: System.data.colorUtil.yellowColor,
                messageStyle: System.data.textStyleUtil.mainLabel(),
                message: ErrorHandlingUtil.handleApiError(
                  System.data.resource.tripAllowanceNotavailable,
                ),
              ),
            );
          } else {
            widget.onTapViewTripAllowance(value.first);
          }
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

  void addTripAllowance() {
    if (widget.onTapAddTripAllowance != null) {
      widget.onTapAddTripAllowance(model.shipment);
    }
  }

  void ontapPickupDetail(int destinationId) {
    if (widget.onTapLoadingDetail != null) {
      widget.onTapLoadingDetail(widget.data, destinationId);
    } else {
      print("on tap shipment loading detail tapped");
    }
  }

  void onTapUnloadingDetail(int destinationId) {
    if (widget.onTapUnloadingDetail != null) {
      widget.onTapUnloadingDetail(widget.data, destinationId);
    } else {
      print("on tap shipment unloading detail tapped");
    }
  }
}
