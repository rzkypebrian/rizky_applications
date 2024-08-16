import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/PendingDataModel.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onTapTrack;
  final String finisButtonLabel;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onTapFinish;
  final ValueChanged<TmsShipmentModel<SieradShipmentDetailHatcheryModel>>
      onTapPendingPod;
  final TmsShipmentModel<SieradShipmentDetailHatcheryModel> data;
  final ValueChanged<TmsDeliveryPodModel> onTapViewPod;

  const Presenter({
    Key key,
    this.view,
    this.onTapTrack,
    this.data,
    this.onTapFinish,
    this.finisButtonLabel,
    this.onTapViewPod,
    this.onTapPendingPod,
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
    SieradShipmentDetailHatcheryModel.getAll(
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

  void viewPod() {
    loadingController.startLoading();
    TmsDeliveryPodModel.get(
      token: System.data.global.token,
      destinationId:
          widget.data.tmsShipmentDestinationList.first.detailshipmentId,
    ).then((value) {
      loadingController.stopLoading();
      if (widget.onTapViewPod != null) {
        widget.onTapViewPod(value);
      }
      {
        ModeUtil.debugPrint(value.toJson());
      }
    }).catchError(
      (onError) {
        ModeUtil.debugPrint("masuk sini");
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
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
}
