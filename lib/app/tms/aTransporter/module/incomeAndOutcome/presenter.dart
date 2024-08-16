import 'package:enerren/util/EnumUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:enerren/util/TypeUtil.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged3Param<int, int, EnumUtil> ontapNext;
  final EnumUtil enumUtil;
  const Presenter({
    Key key,
    this.view,
    this.ontapNext,
    this.enumUtil,
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
  }

  void ontapNext({int year, int month}) {
    if (widget.ontapNext != null) {
      widget.ontapNext(year, month, widget.enumUtil);
    }
  }
}
