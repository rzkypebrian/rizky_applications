import 'package:enerren/model/MaintenanceItemModel.dart';
import 'package:enerren/model/MaintenanceScheduleModel.dart';

import 'package:enerren/model/WorkOrderModel.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ValueChanged<MaintenanceItemModel> sandMaintenancesModel;
  final ObjectBuilder<Future<PersonInChargeModel>> getPersonInChargeModel;
  final ObjectBuilder<Future<MaintenanceScheduleModel>> getMaintenancesModel;
  final ObjectBuilder<Future<VendorModel>> getVendorModel;
  final VoidCallback onSubmitSuccess;

  const Presenter({
    Key key,
    this.view,
    this.sandMaintenancesModel,
    this.getPersonInChargeModel,
    this.getMaintenancesModel,
    this.getVendorModel,
    this.onSubmitSuccess,
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
  }

  void sandMaintenancesModel(MaintenanceItemModel mm) {
    if (widget.sandMaintenancesModel != null) widget.sandMaintenancesModel(mm);
  }

  void getPersonInChargeModel() async {
    if (widget.getPersonInChargeModel != null) {
      final result = await widget.getPersonInChargeModel();
      viewModel.setPersonInChargeModel = result;
      viewModel.picController.text = viewModel.personInChargeModel.name;
      viewModel.commit();
    }
  }

  void getMaintenancesModel() async {
    if (widget.getMaintenancesModel != null) {
      final result = await widget.getMaintenancesModel();
      viewModel.setMaintenancesModel = result;
      viewModel.maintenanceController.text =
          viewModel.maintenanceScheduleModel.maintenanceId;
      viewModel.commit();
    }
  }

  void getVendorModel() async {
    if (widget.getVendorModel != null) {
      final result = await widget.getVendorModel();
      viewModel.setvendorModel = result;
      viewModel.vendorController.text = viewModel.vendorModel.name;
      viewModel.commit();
    }
  }
}
