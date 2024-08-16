import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/model/ShipmentItemDescriptionViewModel.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/model/tmsDeliveryPodModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int tmsShipmentId;
  final int destinationId;
  final String token;
  final ValueChanged<TmsDeliveryPodModel> onTapViewPOD;
  final WidgetFromDataBuilder<CircularProgressIndicatorController>
      loadingDecoration;
  final iconItemAssets;
  final showQtyField;
  final showUnitField;

  Presenter({
    this.view,
    this.tmsShipmentId,
    this.destinationId,
    this.token,
    this.onTapViewPOD,
    this.loadingDecoration,
    this.iconItemAssets,
    this.showQtyField = true,
    this.showUnitField = true,
  });

  @override
  State<StatefulWidget> createState() {
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

  @override
  void initState() {
    super.initState();
    loadingController.startLoading();
    getData();
  }

  void getData() {
    loadingController.startLoading();
    ShipmentItemDescriptionViewModel.loadingShipmentItemDescription(
      token: widget.token,
      tmsShipmentId: widget.tmsShipmentId,
      detailDestinationId: widget.destinationId,
    ).then((value) {
      loadingController.stopLoading();
      model.shipmentItemDescriptions = value;
      model.commit();
    }).catchError((onError) {
      loadingController.stopLoading(
        messageAlign: Alignment.topCenter,
        messageWidget: DecorationComponent.topMessageDecoration(
          message: ErrorHandlingUtil.handleApiError(onError),
        ),
      );
    });
  }

  void onTapViewPOD() {
    loadingController.startLoading();
    TmsDeliveryPodModel.getLoadingPOD(
      token: widget.token,
      destinationId: widget.destinationId ??
          model.shipmentItemDescriptions.first.detailshipmentId,
    ).then((value) {
      if (value.memberId == null && value.destinationId == 0) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            backgroundColor: System.data.colorUtil.yellowColor,
            messageStyle: System.data.textStyleUtil.mainLabel(),
            message: ErrorHandlingUtil.handleApiError(
              System.data.resource.dataIsEmoty,
            ),
          ),
        );
      } else {
        loadingController.stopLoading();
        if (widget.onTapViewPOD != null) {
          widget.onTapViewPOD(value);
        } else {
          ModeUtil.debugPrint("on tap view pod ${value.toJson()}");
        }
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
