import 'package:enerren/model/WorkOrderModel.dart';
import 'package:flutter/material.dart';
import 'view.dart';
import 'viewModel.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback onTapConfirm;
  final VoidCallback onTapDelete;
  final VoidCallback onTapEdit;
  final VendorModel vendorModel;
  final List<ActionButton> listAction;

  const Presenter({
    Key key,
    this.view,
    this.onTapConfirm,
    this.onTapDelete,
    this.onTapEdit,
    this.vendorModel,
    this.listAction = const [
      ActionButton.Delete,
      ActionButton.Edit,
      ActionButton.Confirm,
    ],
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

abstract class PresenterState extends State<Presenter> {
  ViewModel model = new ViewModel();

  @override
  void initState() {
    super.initState();
    model.vendorModel = widget.vendorModel;
  }
}

enum ActionButton {
  Edit,
  Delete,
  Confirm,
}
