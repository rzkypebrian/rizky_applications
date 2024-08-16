import 'package:enerren/app/angkut/aCustomer/LocalData.dart';
import 'package:enerren/app/angkut/model/AngkutShipmentModel.dart';
import 'package:enerren/component/angkutDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:enerren/util/SystemUtil.dart';

import 'viewModel.dart';
import 'view.dart';
import 'package:enerren/component/InputComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final AngkutShipmentModel shipment;
  final ValueChanged<AngkutShipmentModel> onBeforeLogin;
  final ValueChanged<AngkutShipmentModel> onSuccessSubmit;
  final ValueChanged<ViewModel> onTapPaymentMethode;
  final ValueChanged<ViewModel> onTapVoucher;
  final bool showdetailPayment;
  final bool showInchargePersoneSelector;
  final bool showContactPerson;
  final bool showInchageStatus;

  const Presenter({
    Key key,
    this.view,
    this.shipment,
    this.onBeforeLogin,
    this.onSuccessSubmit,
    this.onTapPaymentMethode,
    this.onTapVoucher,
    this.showdetailPayment = true,
    this.showInchargePersoneSelector = true,
    this.showContactPerson = true,
    this.showInchageStatus = true,
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
  ViewModel model = new ViewModel();

  InputComponentTextEditingController personController =
      new InputComponentTextEditingController();
  InputComponentTextEditingController phoneController =
      new InputComponentTextEditingController();

  @override
  void initState() {
    super.initState();
    model.shipment = widget.shipment;
    model.loadingController.stopLoading();
    model.personInCharge(0);
  }

  void submit() {
    model.loadingController.startLoading();
    if (System.data.getLocal<LocalData>().user == null) {
      if (widget.onBeforeLogin != null) {
        widget.onBeforeLogin(model.shipment);
        model.loadingController.stopLoading();
      }
    } else {
      if (widget.onSuccessSubmit != null) {
        System.data.getLocal<LocalData>().newOrder.customerId =
            System.data.getLocal<LocalData>().user.customerId;
        System.data.getLocal<LocalData>().newOrder.voucherCode =
            model.shipment.voucherCode;
        AngkutShipmentModel.calculate(
          token: System.data.global.token,
          createOrderModel: System.data.getLocal<LocalData>().newOrder,
        ).then((calculate) {
          print("calculate result");
          print(calculate.toString());
          calculate.payerName = model.shipment.payerName;
          calculate.payerPhoneNo = model.shipment.payerPhoneNo;
          calculate.shipmentInvoice.methodId =
              model.shipment.shipmentInvoice.methodId;
          calculate.shipmentInvoice.methodName =
              model.shipment.shipmentInvoice.methodName;
          calculate.shipmentInvoice.methodCode =
              model.shipment.shipmentInvoice.methodCode;
          calculate.shipmentInvoice.methodDetailId =
              model.shipment.shipmentInvoice.methodDetailId;
          calculate.shipmentInvoice.methodDetailName =
              model.shipment.shipmentInvoice.methodDetailName;
          calculate.shipmentInvoice.methodDetailCode =
              model.shipment.shipmentInvoice.methodDetailCode;
          calculate.shipmentInvoice.methodDetailIpay88Id =
              model.shipment.shipmentInvoice.methodDetailIpay88Id;
          widget.onSuccessSubmit(calculate);
          model.loadingController.stopLoading();
        }).catchError(
          (errorCalculate) {
            String data = ErrorHandlingUtil.handleApiError(errorCalculate);
            model.loadingController.stopLoading(
              messageAlign: Alignment.topCenter,
              messageWidget: DecorationComponent.topMessageDecoration(
                message: data,
              ),
            );
          },
        );
      }
    }
  }

  void selectPaymentMethode() {
    if (widget.onTapPaymentMethode != null) {
      widget.onTapPaymentMethode(model);
    }
  }

  void onTapVoucher() {
    if (widget.onTapVoucher != null) {
      widget.onTapVoucher(model);
    }
  }
}
