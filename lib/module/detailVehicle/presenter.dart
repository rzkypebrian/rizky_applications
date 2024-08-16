import 'package:enerren/module/detailVehicle/viewModel.dart';
import 'package:enerren/component/circularProgressIndicatorComponent.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'view.dart'; 

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ObjectBuilder<ViewModel> data;
  final ViewModel initData;
  final ValueChanged<ViewModel> onInitData;
  final ValueChanged<ViewModel> onTapDriver;
  final ValueChanged<ViewModel> onTapSearch;

  const Presenter({
    Key key,
    this.view,
    this.onTapDriver,
    this.data,
    this.initData,
    this.onInitData,
    this.onTapSearch,
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
  var tick = 1;
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
  void gotoDriver() {
    if (widget.onTapDriver != null) {
      widget.onTapDriver(model);
    } else {
      ModeUtil.debugPrint("gotodriver");
    }
  }

  void onTapSearch() {
    if (widget.onTapSearch != null) {
      widget.onTapSearch(model);
    }
  }
}
