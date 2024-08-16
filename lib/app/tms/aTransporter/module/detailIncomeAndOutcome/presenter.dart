import 'package:enerren/app/tms/model/IncomeAndOutcomeModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final IncomeAndOutcomeModel incomeAndOutcomeModel;

  const Presenter({
    Key key,
    this.view,
    this.incomeAndOutcomeModel,
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
    viewModel.setIncomeAndOutcomeModel = widget.incomeAndOutcomeModel;
  }

  void ontapNext() {}
  void invoice(){}
}
