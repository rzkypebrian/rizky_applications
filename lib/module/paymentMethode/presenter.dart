import 'package:enerren/model/PaymentMethodeDetailModel.dart';
import 'package:enerren/model/PaymentMethodeModel.dart';
import 'package:enerren/component/sampleDecorationComponent.dart';
import 'package:enerren/util/ErrorHandlingUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final ValueChanged<PaymentMethodeDetailModel> onSelectPaymentMethode;
  final PaymentMethodeDetailModel currentPaymentMethode;

  Presenter({
    this.onSelectPaymentMethode,
    this.currentPaymentMethode,
  });

  @override
  State<StatefulWidget> createState() {
    return View();
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    loadPaymentMethode();
    super.initState();
  }

  void loadPaymentMethode() {
    model.loadingController.startLoading();
    PaymentMethodeModel.getAll(
            // token: System.data.global.token,
            )
        .then((value) {
      model.paymentMethods = value;
      model.commit();
      model.loadingController.stopLoading();
      if (widget.currentPaymentMethode != null) {
        model.selectedMethodDetail = getSelectedPaymentMethode();
      }
    }).catchError(
      (onError) {
        model.loadingController.stopLoading(
          messageAlign: Alignment.topCenter,
          messageWidget: DecorationComponent.topMessageDecoration(
            message: ErrorHandlingUtil.handleApiError(onError),
          ),
        );
      },
    );
  }

  void selectPaymentMethode(
      PaymentMethodeDetailModel paymentMethodeDetailModel) {
    model.selectedMethodDetail = paymentMethodeDetailModel;
    model.commit();
    if (widget.onSelectPaymentMethode != null) {
      widget.onSelectPaymentMethode(paymentMethodeDetailModel);
    }
  }

  PaymentMethodeDetailModel getSelectedPaymentMethode() {
    PaymentMethodeDetailModel _selected;
    model.paymentMethods.forEach((methode) {
      methode.paymentMethodDetails.forEach((methodeDetail) {
        if (methodeDetail.methoDetailId ==
            widget.currentPaymentMethode.methoDetailId) {
          _selected = methodeDetail;
        }
      });
    });
    return _selected;
  }
}
