import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final String paymentUrl;
  final ValueChanged<ViewModel> onPaymentFinished;
  final VoidCallback onTapViewOrder;

  const Presenter({
    Key key,
    this.view,
    this.paymentUrl,
    this.onPaymentFinished,
    this.onTapViewOrder,
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

  @override
  void initState() {
    model.loadingController.stopLoading();
    super.initState();
  }

  void getStatusShipment() {
    model.webViewController.evaluateJavascript("getStatusShipment()").then(
      (value) {
        print("Result $value");
      },
    );
  }

  void onPageLoadFinished(String url) {
    model.loadingController.stopLoading();
    if (url.contains("PaymentResult")) {
      onPaymentResult();
    }
  }

  void onPaymentResult() {
    if (widget.onPaymentFinished != null) {
      widget.onPaymentFinished(model);
    } else {
      model.showButtonNavigationBar = true;
      model.commit();
    }
  }

  void onTapViewOrder() {
    if (widget.onTapViewOrder != null) {
      widget.onTapViewOrder();
    } else {
      ModeUtil.debugPrint("On tap view order");
    }
  }
}
