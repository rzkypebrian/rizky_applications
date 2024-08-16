import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapListVehicle;
  final VoidCallback onTapListMaintenance;
  final VoidCallback onTapWorkOrder;
  final VoidCallback onTapActivities;
  final VoidCallback onTapStock;
  final VoidCallback onTapHistory;

  const Presenter({
    Key key,
    this.view,
    this.onTapListVehicle,
    this.onTapActivities,
    this.onTapStock,
    this.onTapHistory,
    this.onTapListMaintenance,
    this.onTapWorkOrder,
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

  void onTapLitVehicle() {
    if (widget.onTapListVehicle != null) widget.onTapListVehicle();
  }

  void onTapActivities() {
    if (widget.onTapActivities != null) widget.onTapActivities();
  }

  void onTapStock() {
    if (widget.onTapStock != null) widget.onTapStock();
  }

  void onTapHistory() {
    if (widget.onTapHistory != null) widget.onTapHistory();
  }

  void onTapListMaintenance() {
    if (widget.onTapListMaintenance != null) widget.onTapListMaintenance();
  }

  void onTapWorkOrder() {
    if (widget.onTapWorkOrder != null) widget.onTapWorkOrder();
  }
}
