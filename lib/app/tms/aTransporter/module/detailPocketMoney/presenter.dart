import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/model/PointModel.dart';
import 'package:enerren/model/tmsVehicleModel.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

enum SelectAct { Balance, Seep, Insentif }

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final HistoryStockModel historyStockModel;
  final ValueChanged onTapDetailPoint;
  final ValueChanged<TmsVehicleModel> onTapDetailVehicle;
  final ValueChanged<HistoryStockModel> onTapDetail;
  final ValueChanged2Param<String, String> onTapHeroImage;

  const Presenter({
    Key key,
    this.view,
    this.onTapDetail,
    this.onTapDetailPoint,
    this.historyStockModel,
    this.onTapHeroImage, this.onTapDetailVehicle,
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
    viewModel.setHistoryStock = widget.historyStockModel;
  }

  void onTapDetailVehicle(TmsVehicleModel tvm) {
    if (widget.onTapDetailVehicle != null) {
      widget.onTapDetailVehicle(tvm);
    }
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

  void ontapDetail(HistoryStockModel hsm){

  }

  void onTapHeroImage({String name, String path}) {
    if (widget.onTapHeroImage != null) widget.onTapHeroImage(name, path);
  }
}
