import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/app/sierad/model/sieradDeliverStock.dart';
import 'package:enerren/component/sieradDecorationComponent.dart';
import 'package:enerren/model/tmsShipmentModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'package:enerren/util/StringExtention.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged2Param<TmsShipmentModel, SieradDeliverStock> onSuccess;
  final TmsShipmentModel shipment;

  const Presenter({
    Key key,
    this.view,
    this.onSuccess,
    this.shipment,
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
  var tick = 1;
  final CircularProgressIndicatorController loadingController =
      new CircularProgressIndicatorController();

  InputComponentTextEditingController numberOfVaccineReceivedController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController numberOfLiveBirdDeadController =
      new InputComponentTextEditingController();

  FocusNode numberOfDocNode = new FocusNode();
  FocusNode numberOfDocDeadNode = new FocusNode();
  FocusNode numberOfDocBonusNode = new FocusNode();
  FocusNode numberOfBoxFocuseNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    try {
      numberOfVaccineReceivedController.text = widget.shipment
          .tmsShipmentDestinationList.first.shipmentDetailDataObject.orderQty
          .toString();

      numberOfLiveBirdDeadController.text = "0";
    } catch (e) {
      //
    }
    loadingController.stopLoading();
  }

  bool validateNumberOfDoc() {
    if (numberOfVaccineReceivedController.content.toString().isNullOrEmpty()) {
      numberOfVaccineReceivedController.setStateInput = StateInput.Error;
      return false;
    } else {
      numberOfVaccineReceivedController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateNumberOfDead() {
    if (numberOfLiveBirdDeadController.content.toString().isNullOrEmpty()) {
      numberOfLiveBirdDeadController.setStateInput = StateInput.Error;
      return false;
    } else {
      numberOfLiveBirdDeadController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateNumberOfDoc() ?? isValid;
    isValid = validateNumberOfDead() ?? isValid;
    return isValid;
  }

  //sample navigation
  void submit() {
    if (!validate()) return;
    ModeUtil.debugPrint(widget.shipment);
    if (widget.onSuccess != null) {
      try {
        widget.onSuccess(
          widget.shipment,
          new SieradDeliverStock(
              // driverId: widget.shipment.tmsShipmentDestinationList.first.driverId,
              // // driverId: System.data.getLocal<LocalData>().user.driverId,
              // driverName:
              //     widget.shipment.tmsShipmentDestinationList.first.driverName,
              // poultryShipmentId: widget.shipment.tmsShipmentDestinationList.first
              //     .shipmentDetailDataObject.poultryShipmentId,
              // qtyLiveBirdDead: int.parse(numberOfLiveBirdDeadController.content),
              // qtyLiveBirdReceived:
              //     int.parse(numberOfVaccineReceivedController.content),
              ),
        );
      } catch (e) {
        loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(e),
          ),
        );
      }
    }
  }
}
