import 'package:enerren/app/tms/model/IncomeAndOutcomeModel.dart';
import 'package:enerren/util/EnumUtil.dart';
import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final int year;
  final int month;
  final EnumUtil enumUtil;
  final ValueChanged<IncomeAndOutcomeModel> ontapDetailIncomeAndOutcome;

  const Presenter({
    Key key,
    this.view,
    this.year,
    this.month,
    this.enumUtil = EnumUtil.Income,
    this.ontapDetailIncomeAndOutcome,
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
    ModeUtil.debugPrint("year ${widget.year} month ${widget.month}");
  }

  void ontapNext() {}
  void ontapDetailIncomeAndOutcome(IncomeAndOutcomeModel iom) {
    if (widget.ontapDetailIncomeAndOutcome != null)
      widget.ontapDetailIncomeAndOutcome(iom);
  }
}
