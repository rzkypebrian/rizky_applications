import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<PersonInChargeModel> onSelectedPersonInChargeModel;

  const Presenter({
    Key key,
    this.view,
    this.onSelectedPersonInChargeModel,
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

  void onSelectedPersonInChargeModel(PersonInChargeModel pm) {
    if (widget.onSelectedPersonInChargeModel != null)
      widget.onSelectedPersonInChargeModel(pm);
  }
}
