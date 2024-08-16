import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final MaintenanceItemModel detailMaintenancesModel;
  final ValueChanged<MaintenanceItemModel> selectedMaintenancesModel;

  const Presenter({
    Key key,
    this.view,
    this.detailMaintenancesModel,
    this.selectedMaintenancesModel,
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
  ViewModel viewModel = ViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.controller.stopLoading();
    viewModel.maintenancesModel = widget.detailMaintenancesModel;
  }

  void selectedMaintenancesModel(MaintenanceItemModel mm) {
    if (widget.selectedMaintenancesModel != null)
      widget.selectedMaintenancesModel(mm);
  }
}
