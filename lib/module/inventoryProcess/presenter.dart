import 'package:enerren/model/MaintenanceScheduleModel.dart';
import 'package:enerren/util/TypeUtil.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final ObjectBuilder<Future<MaintenanceScheduleModel>>
      maintenanceModelSelector;
  final String processTitle;
  final List<InputDataField> inputDataItems;
  final VoidCallback onSubmitSuccess;

  const Presenter({
    Key key,
    this.view,
    this.maintenanceModelSelector,
    this.processTitle,
    this.inputDataItems = const [
      InputDataField.PRnumber,
      InputDataField.MaintenanceId,
      InputDataField.ProductSource,
      InputDataField.ProductStatus,
      InputDataField.ProductName,
      InputDataField.ProductTotal,
      InputDataField.ProductPrice,
      InputDataField.Vendor,
      InputDataField.ProductPhoto,
    ],
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
  List<InputDataField> inputDataItem = [];

  @override
  void initState() {
    super.initState();
    inputDataItem = widget.inputDataItems;
    viewModel.controller.stopLoading();
    // viewModel.setTypeProcessStock = widget.typeProcessStock ?? 1;
  }

  void getMaintenanceId() async {
    if (widget.maintenanceModelSelector != null) {
      final result = await widget.maintenanceModelSelector();
      viewModel.setMaintenanceModel = result;
      viewModel.maintenanceIdController.text =
          viewModel.getMaintenanceModel.maintenanceId;
      viewModel.commit();
    }
  }
}

enum InputDataField {
  PRnumber,
  MaintenanceId,
  ProductSource,
  ProductStatus,
  ProductName,
  ProductTotal,
  ProductPrice,
  Vendor,
  ProductPhoto,
}
