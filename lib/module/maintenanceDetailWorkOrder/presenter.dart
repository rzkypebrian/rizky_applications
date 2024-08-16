import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final WorkOrderModel getWorkOrderModel;
  final ValueChanged<WorkOrderModel> selectedWorkOrderModel;

  const Presenter({
    Key key,
    this.view,
    this.getWorkOrderModel,
    this.selectedWorkOrderModel,
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
    viewModel.setgetWorkOrderModel = widget.getWorkOrderModel;
  }

  void selectedWorkOrderModel(WorkOrderModel wo) {
    if (widget.selectedWorkOrderModel != null)
      widget.selectedWorkOrderModel(wo);
  }
}
