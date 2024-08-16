import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/util/constantUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<MaintenanceItemModel> sandMaintenancesModel;
  final ValueChanged<MaintenanceItemModel> editMaintenancesModel;
  final MaintenanceItemModel getMaintenanceItemModel;
  final VoidCallback backToList;
  final EnumType enumType;

  const Presenter({
    Key key,
    this.view,
    this.sandMaintenancesModel,
    this.enumType = EnumType.InputData,
    this.editMaintenancesModel,
    this.getMaintenanceItemModel, this.backToList,
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
    viewModel.setEnumType = widget.enumType;
    if (widget.enumType == EnumType.EditData) {
      viewModel.setmaintenancesModel = widget.getMaintenanceItemModel;
    }
  }

  void sandMaintenancesModel(MaintenanceItemModel mm) {
    if (widget.sandMaintenancesModel != null) widget.sandMaintenancesModel(mm);
  }

  void editMaintenancesModel(MaintenanceItemModel mm) {
    if (widget.editMaintenancesModel != null) widget.editMaintenancesModel(mm);
  }
  void backToList() {
    if (widget.backToList != null) widget.backToList();
  }
}
