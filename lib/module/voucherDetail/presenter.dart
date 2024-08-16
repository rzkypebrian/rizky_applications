import 'package:enerren/model/TmsVoucherModel.dart';
import 'package:flutter/material.dart';
import 'viewModel.dart';
import 'view.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final TmsVoucherModel voucher;
  final VoidCallback onApplay;

  const Presenter({
    Key key,
    this.view,
    this.onApplay,
    this.voucher,
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
    model.voucher = widget.voucher ?? model.voucher;
    model.loadingController.stopLoading();
    super.initState();
  }

  void onTapApplay() {
    if (widget.onApplay != null) {
      widget.onApplay();
    }
  }
}
