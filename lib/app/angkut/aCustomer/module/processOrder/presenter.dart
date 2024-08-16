import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/aCustomer/module/processOrder/viewModel.dart';
import 'package:enerren/app/angkut/aCustomer/module/processOrder/view.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:flutter/material.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final bool submitOrder;
  final AngkutShipmentModel shipmentModel;
  final ValueChanged<AngkutShipmentModel> onSubmitSuccess;
  final ValueChanged<AngkutShipmentModel> onTapButtonFInish;
  final String buttonFinishTitle;
  final bool showPrize;
  final bool showExtraPeople;
  final String animationAssets;
  final String animationName;

  const Presenter({
    Key key,
    this.view,
    this.submitOrder = true,
    @required this.shipmentModel,
    this.onSubmitSuccess,
    this.onTapButtonFInish,
    this.buttonFinishTitle,
    this.showPrize = true,
    this.showExtraPeople = false,
    this.animationAssets,
    this.animationName,
  }) : super(key: key);

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
  ViewModel data = new ViewModel();
  String animation = "Play";
  @override
  void initState() {
    super.initState();
    data.shipmentModel = widget.shipmentModel;
    data.commit();
    if (widget.submitOrder) {
      submitOrder();
    }
  }

  void submitOrder() {
    print(
        "create shipment order ${widget.shipmentModel.shipmentInvoice.methodDetailIpay88Id}");
    print("angkut shipment model ${widget.shipmentModel.toJson()}");
    System.data.getLocal<LocalData>().isConfirmOrderSuccess = false;
    System.commit();
    AngkutShipmentModel.createOrder(
      token: System.data.global.token,
      angkutShipmentModel: widget.shipmentModel,
    ).then((newOrder) {
      print(
          "new shipment order ${newOrder.shipmentInvoice.methodDetailIpay88Id}");
      data.shipmentModel = newOrder;
      data.isFinish = true;
      System.data.getLocal<LocalData>().isConfirmOrderSuccess = true;
      System.commit();
      data.commit();
      if (widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess(data.shipmentModel);
      }
    }).catchError((errorNewOrder) {
      String error = ErrorHandlingUtil.handleApiError(errorNewOrder);
      data.isFinish = true;
      data.message = error;
      System.data.getLocal<LocalData>().isConfirmOrderSuccess = false;
      System.commit();
      data.commit();
    });
  }

  void onTapViewOrder() {
    if (widget.onTapButtonFInish != null) {
      print(
          "new shipment order ${data.shipmentModel.shipmentInvoice.methodDetailIpay88Id}");
      widget.onTapButtonFInish(data.shipmentModel);
    }
  }
}
