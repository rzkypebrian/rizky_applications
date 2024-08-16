import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback ontapPay;
  final VoidCallback ontapReceived;

  const Presenter({
    Key key,
    this.view,
    this.ontapPay,
    this.ontapReceived,
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

abstract class PresenterState extends State<Presenter>
    with TickerProviderStateMixin {
  ViewModel viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.controller.stopLoading();
  }

  void ontapPay() {
    if (widget.ontapPay != null) widget.ontapPay();
  }

  void ontapReceived() {
    if (widget.ontapReceived != null) widget.ontapReceived();
  }
}
