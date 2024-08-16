import 'package:enerren/model/HistoryStockModel.dart'; 
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<HistoryStockModel> onTapDetailHistoryStock;

  const Presenter({
    Key key,
    this.view,
    this.onTapDetailHistoryStock,
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
    viewModel.tabController = TabController(vsync: this, length: 3)
      ..addListener(() {});
  }

  void onTapDetailHistoryStock(HistoryStockModel hsm) {
    if (widget.onTapDetailHistoryStock != null) widget.onTapDetailHistoryStock(hsm);
  }
  // void onTapDetailInsentif(DetailInsentifModel dim) {
  //   if (widget.onTapDetailInsentif != null) widget.onTapDetailInsentif(dim);
  // }
 
}
