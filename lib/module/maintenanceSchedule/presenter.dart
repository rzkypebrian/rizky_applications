import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/SystemUtil.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<MaintenanceScheduleModel> onSelected;
  final List<MaintenanceTab> tabs;

  const Presenter(
      {Key key,
      this.view,
      this.onSelected,
      this.tabs = const <MaintenanceTab>[
        MaintenanceTab.WillOverdue,
        MaintenanceTab.Overdue,
        MaintenanceTab.Finish,
      ]})
      : super(key: key);

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
    with SingleTickerProviderStateMixin {
  ViewModel viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.controller.stopLoading();
    ModeUtil.debugPrint("viewModel.getFinish ${viewModel.getAlreadyFinish}");
    viewModel.tabController = TabController(
      vsync: this,
      length: widget.tabs.length,
      initialIndex: 0,
    )..addListener(
        () => viewModel.setCurrentIndexTab = viewModel.tabController.index);
  }

  void onSelectedData(MaintenanceScheduleModel mm) {
    if (widget.onSelected != null) {
      widget.onSelected(mm);
    }
  }

  String getTabLabel(MaintenanceTab tab) {
    switch (tab) {
      case MaintenanceTab.WillOverdue:
        return System.data.resource.willBeDue;
        break;
      case MaintenanceTab.Overdue:
        return System.data.resource.dueDate;
        break;
      case MaintenanceTab.WillOverdue:
        return System.data.resource.finish;
        break;
      default:
        return System.data.resource.finish;
        break;
    }
  }
}
