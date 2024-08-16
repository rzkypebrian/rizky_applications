import 'package:enerren/model/MaintenanceItemModel.dart'; 
import 'package:flutter/material.dart';
import 'main.dart';

class Presenter extends StatefulWidget {
  final State<Presenter> view;
  final VoidCallback addNewMaintenance;
  final ValueChanged<MaintenanceItemModel> detailNewMaintenance;

  const Presenter({
    Key key,
    this.view,
    this.addNewMaintenance,
    this.detailNewMaintenance,
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

  void addNewMaintenance() {
    if (widget.addNewMaintenance != null) widget.addNewMaintenance();
  }

  void detailNewMaintenance(MaintenanceItemModel mm) {
    if (widget.detailNewMaintenance != null) widget.detailNewMaintenance(mm);
  }
}
