import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/model/PointModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:enerren/util/SystemUtil.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final bool finish;
  final ValueChanged onTapDetail;
  final ValueChanged onTapDetailPoint;
  final ValueChanged2Param<String, String> onTapHeroImage;

  const Presenter({
    Key key,
    this.view,
    this.finish,
    this.onTapDetail,
    this.onTapDetailPoint,
    this.onTapHeroImage,
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

    viewModel
        .tabController = TabController(vsync: this, length: 3, initialIndex: 0)
      ..addListener(
          () => viewModel.setCurrentIndexTab = viewModel.tabController.index);
  }

  void sendBackData(MaintenanceScheduleModel mm) {
    System.data.routes.pop(context, mm);
  }

  void onTapDetail(HistoryStockModel sm) {
    if (widget.onTapDetail != null) {
      widget.onTapDetail(sm);
    }
  }

  void detailPoint(PointModel pm) {
    ModeUtil.debugPrint("message ${pm.numberOder}");
    if (widget.onTapDetailPoint != null) widget.onTapDetailPoint(pm);
  }

  void onTapHeroImage({String name, String path}) {
    if (widget.onTapHeroImage != null) widget.onTapHeroImage(name, path);
  }
}
