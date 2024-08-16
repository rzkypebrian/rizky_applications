import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<VendorModel> onSelectedPersonInChargeModel;
  final VoidCallback addVendor;

  const Presenter({
    Key key,
    this.view,
    this.onSelectedPersonInChargeModel,
    this.addVendor,
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
  ViewModel viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.controller.stopLoading();
  }

  void onSelectedPersonInChargeModel(VendorModel pm) {
    if (widget.onSelectedPersonInChargeModel != null)
      widget.onSelectedPersonInChargeModel(pm);
  }

  void addVendor() {
    if (widget.addVendor != null) widget.addVendor();
  }
}
