import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final List<TabName> tabName;
  final ValueChanged<WorkOrderModel> selecetedWorkOrderModel;

  const Presenter({
    Key key,
    this.view,
    this.tabName = const [
      TabName.New,
      TabName.Process,
      TabName.Finish,
      TabName.Postponed
    ],
    this.selecetedWorkOrderModel,
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
    viewModel.tabController = TabController(
        length: widget.tabName.length, vsync: this, initialIndex: 0)
      ..addListener(() {});
  }

  void selecetedWorkOrderModel(WorkOrderModel wo) {
    if (widget.selecetedWorkOrderModel != null)
      widget.selecetedWorkOrderModel(wo);
  }
}
