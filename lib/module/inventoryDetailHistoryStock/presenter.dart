import 'package:enerren/model/HistoryStockModel.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final HistoryStockModel historyStockModel;
  final ValueChanged2Param<String, String> onTapHeroImage;

  const Presenter({
    Key key,
    this.view,
    this.historyStockModel,
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
    with SingleTickerProviderStateMixin {
  ViewModel viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.controller.stopLoading();
    viewModel.addStock = widget.historyStockModel;
  }

  void onTapHeroImage({String name, String path}) {
    if (widget.onTapHeroImage != null) widget.onTapHeroImage(name, path);
  }
}
