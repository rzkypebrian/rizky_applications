import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapListVehicle;
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
}
