import 'package:enerren/component/InputComponent.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/app/sierad/model/SieradShipmentDetailHatcheryModel.dart';
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
  final ValueChanged2Param<TmsShipmentModel<SieradShipmentDetailHatcheryModel>,
      SieradDeliverStock> onSuccess;
  final TmsShipmentModel<SieradShipmentDetailHatcheryModel> shipment;

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

  InputComponentTextEditingController numberOfDocController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController numberOfDocDeadController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController numberOfDocBonusController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController numberOfBoxController =
      new InputComponentTextEditingController();

  FocusNode numberOfDocNode = new FocusNode();
  FocusNode numberOfDocDeadNode = new FocusNode();
  FocusNode numberOfDocBonusNode = new FocusNode();
  FocusNode numberOfBoxFocuseNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    try {
      numberOfBoxController.text = widget.shipment.tmsShipmentDestinationList
          .first.shipmentDetailDataObject.basketQty
          .toString();
      numberOfDocController.text = widget.shipment.tmsShipmentDestinationList
          .first.shipmentDetailDataObject.orderQty
          .toString();
      numberOfDocBonusController.text = widget.shipment
          .tmsShipmentDestinationList.first.shipmentDetailDataObject.bonusQty
          .toString();
      numberOfDocDeadController.text = "0";
    } catch (e) {
      //
    }
    loadingController.stopLoading();
  }

  bool validateNumberOfDoc() {
    if (numberOfDocController.content.toString().isNullOrEmpty()) {
      numberOfDocController.setStateInput = StateInput.Error;
      return false;
    } else {
      numberOfDocController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateNumberOfDead() {
    if (numberOfDocDeadController.content.toString().isNullOrEmpty()) {
      numberOfDocDeadController.setStateInput = StateInput.Error;
      return false;
    } else {
      numberOfDocDeadController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateNumberOfBonus() {
    if (numberOfDocBonusController.content.toString().isNullOrEmpty()) {
      numberOfDocBonusController.setStateInput = StateInput.Error;
      return false;
    } else {
      numberOfDocBonusController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validateNumberOfBox() {
    if (numberOfBoxController.content.toString().isNullOrEmpty()) {
      numberOfBoxController.setStateInput = StateInput.Error;
      return false;
    } else {
      numberOfBoxController.setStateInput = StateInput.Enable;
      return null;
    }
  }

  bool validate() {
    bool isValid = true;
    isValid = validateNumberOfDoc() ?? isValid;
    isValid = validateNumberOfDead() ?? isValid;
    isValid = validateNumberOfBonus() ?? isValid;
    isValid = validateNumberOfBox() ?? isValid;
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
            driverId: widget.shipment.tmsShipmentDestinationList.first.driverId,
            // driverId: System.data.getLocal<LocalData>().user.driverId,
            driverName:
                widget.shipment.tmsShipmentDestinationList.first.driverName,
            poultryShipmentId: widget.shipment.tmsShipmentDestinationList.first
                .shipmentDetailDataObject.poultryShipmentId,
            qtyBasketReceived: int.parse(numberOfBoxController.content),
            qtyBonusReceived: int.parse(numberOfDocBonusController.content),
            qtyBrokenReceived: int.parse(numberOfDocDeadController.content),
            qtyReceived: int.parse(numberOfDocController.content),
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
