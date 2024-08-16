import 'package:enerren/util/ModeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapIncoming;
  final VoidCallback onTappayment;
  const Presenter({
    Key key,
    this.view,
    this.onTapIncoming,
    this.onTappayment,
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
  ViewModel viewModel = ViewModel();

  void incoming() {
    if (widget.onTapIncoming != null) {
      widget.onTapIncoming();
    } else {
      ModeUtil.debugPrint("on tap incoming");
    }
  }

  void payment() {
    if (widget.onTappayment != null) {
      widget.onTappayment();
    } else {
      ModeUtil.debugPrint("on tap payment");
    }
  }
}
