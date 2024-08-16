import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<ViewModel> onTapVehicle;
  final ObjectBuilder<ViewModel> data;
  final ViewModel initData;
  final ValueChanged<ViewModel> onInitData;

  const Presenter({
    Key key,
    this.view,
    this.onTapVehicle,
    this.data,
    this.initData,
    this.onInitData,
  }) : super(key: key);

  createState() {
    if (view != null) {
      return view;
    } else {
      return View();
    }
  }
}

abstract class PresenterState extends State<Presenter> {
  ViewModel model;
  final CircularProgressIndicatorController controller =
      new CircularProgressIndicatorController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      model = widget.data();
      if (model == null) {
        model = new ViewModel();
      }
    } else {
      model = new ViewModel();
    }

    if (widget.initData != null) {
      model.copy(widget.initData);
      model.commit();
    }

    if (widget.onInitData != null) {
      widget.onInitData(model);
      model.commit();
    }
  }

  //sample navigation
  void onTapVehicle() {
    if (widget.onTapVehicle != null) {
      widget.onTapVehicle(model);
    }
  }
}
