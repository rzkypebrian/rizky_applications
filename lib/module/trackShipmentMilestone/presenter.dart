import 'package:enerren/component/InputComponent.dart';
import 'package:flutter/material.dart';
import 'package:enerren/util/StringExtention.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;

  const Presenter({
    Key key,
    this.view,
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
  ViewModel model = new ViewModel();
  InputComponentTextEditingController resiController =
      new InputComponentTextEditingController();
  TabController tabController;
  TabController listController;

  void initState() {
    super.initState();
    model.receiptIdDummy();
    tabController = TabController(length: 2, vsync: this);
  }

  bool validateResiController() {
    if (resiController.text.isNullOrEmpty()) {
      resiController.setStateInput = StateInput.Error;
    } else {
      resiController.setStateInput = StateInput.Enable;
    }
    return null;
  }

  bool validate() {
    bool isValid = true;
    isValid = validateResiController() ?? isValid;
    return isValid;
  }

  void submit() {
    if (validate() == null) {
      Navigator.of(context).pop();
    } else {
      validate();
    }
  }
}
